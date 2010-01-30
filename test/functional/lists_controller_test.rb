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

      should "show the current item" do
        get :current_item, :id => @list.id
        @list.reload
        assert_response :success
        @item = assigns(:item)
        
        assert_equal @item, @list.current_item
        assert(@item.last_seen > 2.seconds.ago, "current item should be just seen")
        assert_contains @list.items.uncompleted, @item
      end

      should "return the same item each time" do
        get :current_item, :id => @list.id
        item1 = assigns(:item)
        get :current_item, :id => @list.id
        item2 = assigns(:item)
        assert_equal item1, item2
      end

      should "mark the current item completed" do
        get :current_item, :id => @list.id
        item = assigns(:item)
        post :current_item_completed, :id => @list.id
        assert_redirected_to lists_url
        @list.reload
        item.reload
        
        assert item.completed
        assert item.date_completed > 2.seconds.ago
        assert_nil @list.current_item
      end
    end

  end

  should "have the correct routes setup" do
    assert_generates "/", {:controller => :lists, :action => :buttons}
  end

  test "should show list" do
    get :show, :id => lists(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => lists(:one).to_param
    assert_response :success
  end

  test "should update list" do
    put :update, :id => lists(:one).to_param, :list => { }
    assert_redirected_to list_path(assigns(:list))
  end

  test "should destroy list" do
    assert_difference('List.count', -1) do
      delete :destroy, :id => lists(:one).to_param
    end

    assert_redirected_to lists_path
  end
end
