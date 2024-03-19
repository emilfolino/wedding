require 'test_helper'

class WeddingDescriptionsControllerTest < ActionController::TestCase
  setup do
    @wedding_description = wedding_descriptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wedding_descriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wedding_description" do
    assert_difference('WeddingDescription.count') do
      post :create, wedding_description: { body: @wedding_description.body, language_id: @wedding_description.language_id, wedding_id: @wedding_description.wedding_id }
    end

    assert_redirected_to wedding_description_path(assigns(:wedding_description))
  end

  test "should show wedding_description" do
    get :show, id: @wedding_description
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wedding_description
    assert_response :success
  end

  test "should update wedding_description" do
    patch :update, id: @wedding_description, wedding_description: { body: @wedding_description.body, language_id: @wedding_description.language_id, wedding_id: @wedding_description.wedding_id }
    assert_redirected_to wedding_description_path(assigns(:wedding_description))
  end

  test "should destroy wedding_description" do
    assert_difference('WeddingDescription.count', -1) do
      delete :destroy, id: @wedding_description
    end

    assert_redirected_to wedding_descriptions_path
  end
end
