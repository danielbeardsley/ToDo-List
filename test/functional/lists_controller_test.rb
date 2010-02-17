require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  context "get index" do
    setup do
      get :index
    end

    should_respond_with :success
  end

  context "get new" do
    setup do
      get :new
    end

    should_respond_with :success
  end

  context "a list created" do
    setup do
      post :create, :list => {:name => "Something"}
      @list = assigns(:list)
    end

    should_change('List count', :by => 1) {List.count}
    should_redirect_to("the lists view page") { list_path(assigns(:list)) }

    should_set_the_flash_to(/was successfully/)

    context "with items" do
      setup do
        @list.items.create(:title => 'item 1a')
        @list.items.create(:title => 'item 1b')
      end
    end

    context "and updated" do
      setup do
        post :update, :id => @list.to_param, :list => { :name => 'new name' }
      end

      should_redirect_to("the lists view page") { list_path(assigns(:list)) }

      should "be changed" do
        @list.reload
        assert_equal 'new name', @list.name
      end
    end
  end

  should "have the correct routes setup" do
    assert_generates "/", {:controller => :lists, :action => :buttons}
  end

  context "with several lists" do
    setup do
      @lists = (1..3).map do |i|
        Factory.create :empty_list, :name => "List #{i}"
      end
    end

    context "the buttons page" do
      setup do
        get :buttons
      end

      should_respond_with :success

      should "show the names of all the lists" do
        @lists.each do |l|
          assert_response_contains l.name
        end
      end

      should "show have several links for each list" do
        @lists.each do |l|
          assert_select "a[href=#{new_list_item_url(l.id)}]", true
          assert_select "a[href=#{get_list_current_item_url(l.id)}]", true
        end
      end
    end
  end

  test "should show list" do
    get :show, :id => lists(:one).to_param
    assert_response :success
  end

  context "the edit page" do
    setup do
      get :edit, :id => lists(:one).to_param
    end
    
    should_respond_with :success
  end


  test "should destroy list" do
    assert_difference('List.count', -1) do
      delete :destroy, :id => lists(:one).to_param
    end

    assert_redirected_to lists_path
  end
end
