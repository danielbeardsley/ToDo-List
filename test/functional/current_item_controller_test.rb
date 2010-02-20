require 'test_helper'

class CurrentItemsControllerTest < ActionController::TestCase

  context "a list with several items" do
    setup do
      @list = List.create(:name => 'List1')
      @items = (1..3).to_a.map do |i|
        @list.items.create(:title => "Item #{i}  #{rand}")
      end
    end
    
    context "who's current item is requested" do
      setup do
        post :get, :list_id => @list.to_param
        @current_item = assigns(:current_item)
      end
      
      should_respond_with :success

      should "get the current_item" do
        assert_not_nil @current_item
        assert !@current_item.completed
      
        assert_response_contains @current_item.title
      end

      should "have links to defer the current item or mark it completed" do
        assert_select "a[href=#{complete_list_current_item_path(@list)}]"
        assert_select "a[href=#{defer_list_current_item_path(@list)}]"
      end

      should "get the same current_item when it's requested twice " do
        post :get, :list_id => @list.to_param
        @list.reload
        current_item = @list.get_current_item
        assert_response :success

        assert_equal @current_item, current_item
        assert_response_contains @current_item.title
        assert !@current_item.completed
      end

      context "then marked as completed" do
        setup do
          post 'complete', :list_id => @list.to_param
          @current_item.reload
        end

        should_redirect_to('Buttons Page') { buttons_page }

        should "be marked as completed" do
          assert @current_item.completed
          d = @current_item.date_completed
          assert(d <= DateTime.now && d > 1.minute.ago, "date_completed should be right now")
        end

        should "choose a new current_item" do
          post :get, :list_id => @list.to_param
          new_item = assigns(:current_item)
          assert_not_equal @current_item, new_item
          assert_not_equal @list.reload.get_current_item, @current_item

          assert !new_item.completed
        end

        should_change("Item model's uncompleted count", :by => -1) {Item.uncompleted.count}
      end

      context "then deferred" do
        setup do
          post 'defer', :list_id => @list.to_param
          @current_item.reload
        end

        should_redirect_to('Buttons Page') { buttons_page }

        should "not be marked as completed" do
          assert !@current_item.completed
          assert_nil @current_item.date_completed
        end

        should "unset the current_item" do
          assert_nil @list.current_item
        end

        should_not_change("Item model's uncompleted count") {Item.uncompleted.count}
      end
    end
  end

end
