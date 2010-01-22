require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
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

  context "an item created" do
    setup do
      post :create, :item => {:title => "Something", :type => Item.allowed_types.first }
      @item = assigns(:item)
    end

    should_change('Item count', :by => 1) {Item.count}
    should_redirect_to("the items view page") { item_path(assigns(:item)) }

    should_set_the_flash_to(/was successfully/)

    context "then marked as completed" do
      setup do
        post 'complete', :id => @item.id
        @item.reload
      end

      should "be marked as completed" do
        assert @item.completed
        d = @item.date_completed
        assert(d <= DateTime.now && d > 1.minute.ago, "date_completed should be right now")
      end

      should_change("Item model's uncompleted count", :by => -1) {Item.uncompleted.count}
    end

  end

  should "show item" do
    get :show, :id => items(:one).to_param
    assert_response :success
  end

  should "get edit" do
    get :edit, :id => items(:one).to_param
    assert_response :success
  end

  should "update item" do
    put :update, :id => items(:one).to_param, :item => {:title => "Else!!", :type => Item.allowed_types.last }
    assert_redirected_to item_path(assigns(:item))
  end

  should "destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, :id => items(:one).to_param
    end

    assert_redirected_to items_path
  end
end
