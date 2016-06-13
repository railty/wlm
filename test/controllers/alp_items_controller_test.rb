require 'test_helper'

class AlpItemsControllerTest < ActionController::TestCase
  setup do
    @alp_item = alp_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alp_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alp_item" do
    assert_difference('AlpItem.count') do
      post :create, alp_item: {  }
    end

    assert_redirected_to alp_item_path(assigns(:alp_item))
  end

  test "should show alp_item" do
    get :show, id: @alp_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alp_item
    assert_response :success
  end

  test "should update alp_item" do
    patch :update, id: @alp_item, alp_item: {  }
    assert_redirected_to alp_item_path(assigns(:alp_item))
  end

  test "should destroy alp_item" do
    assert_difference('AlpItem.count', -1) do
      delete :destroy, id: @alp_item
    end

    assert_redirected_to alp_items_path
  end
end
