require 'test_helper'

class InvitationTextsControllerTest < ActionController::TestCase
  setup do
    @invitation_text = invitation_texts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invitation_texts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invitation_text" do
    assert_difference('InvitationText.count') do
      post :create, invitation_text: { body: @invitation_text.body, language_id: @invitation_text.language_id, wedding_id: @invitation_text.wedding_id }
    end

    assert_redirected_to invitation_text_path(assigns(:invitation_text))
  end

  test "should show invitation_text" do
    get :show, id: @invitation_text
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @invitation_text
    assert_response :success
  end

  test "should update invitation_text" do
    patch :update, id: @invitation_text, invitation_text: { body: @invitation_text.body, language_id: @invitation_text.language_id, wedding_id: @invitation_text.wedding_id }
    assert_redirected_to invitation_text_path(assigns(:invitation_text))
  end

  test "should destroy invitation_text" do
    assert_difference('InvitationText.count', -1) do
      delete :destroy, id: @invitation_text
    end

    assert_redirected_to invitation_texts_path
  end
end
