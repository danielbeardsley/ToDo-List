require 'test_helper'

class CurrentItemControllerTest < ActionController::TestCase

  context "a list with several items" do
    setup do
      @list = List.create(:name => 'List1')
      @items = (1..3).to_a.map do |i|
        @list.items.create(:title => "Item #{i}  #{rand}")
      end
    end
    
    context "who's current item is requested" do
      setup do
        get :get, :list_id => @list.to_param
      end
      
      should_respond_with :success

      should "get the current_item" do
        current_item = @list.get_current_item
        assert_not_nil current_item
        assert !current_item.completed
      
        assert_response_contains current_item.title
      end

      should "get the same current_item when it's requested twice " do
        first_item = @list.get_current_item
        get :get, :list_id => @list.to_param
        assert_response :success

        assert_response_contains first_item.title
        assert !current_item.completed
      end
    end
  end

end
