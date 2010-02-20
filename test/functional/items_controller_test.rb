require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  context "" do
    setup do
      @list = List.create(:name => "List 1")
    end

    context "get index" do
      setup do
        get :index, :list_id => @list.to_param
      end

      should_respond_with :success
    end

    context "get new" do
      setup do
        get :new, :list_id => @list.to_param
      end

      should_respond_with :success
      should "have the list name on the page" do
        assert_response_contains @list.name
      end
    end

    context "an item created" do
      setup do
        post :create, :list_id => @list.to_param, :item => {:title => "Something"}
        @item = assigns(:item)
      end

      should_change('Item count', :by => 1) {Item.count}
      should_redirect_to("Buttons page") { buttons_page }

      should_set_the_flash_to(/was successfully/)

      context "and then marked as completed" do
        setup do
          post :complete, :item_id => @item.id
        end

        should "mark the item as completed" do
          @item.reload
          assert @item.completed
        end
        
        should_redirect_to("List index page") { list_items_path(@item.list_id) }
      end
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
    put :update, :id => items(:one).to_param, :item => {:title => "Else!!"}
    assert_redirected_to item_path(assigns(:item))
  end

  should "destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, :id => items(:one).to_param
    end

    assert_redirected_to list_items_path(items(:one).list_id)
  end
end
