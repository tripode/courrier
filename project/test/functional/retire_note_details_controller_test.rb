require 'test_helper'

class RetireNoteDetailsControllerTest < ActionController::TestCase
  setup do
    @retire_note_detail = retire_note_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:retire_note_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create retire_note_detail" do
    assert_difference('RetireNoteDetail.count') do
      post :create, retire_note_detail: @retire_note_detail.attributes
    end

    assert_redirected_to retire_note_detail_path(assigns(:retire_note_detail))
  end

  test "should show retire_note_detail" do
    get :show, id: @retire_note_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @retire_note_detail
    assert_response :success
  end

  test "should update retire_note_detail" do
    put :update, id: @retire_note_detail, retire_note_detail: @retire_note_detail.attributes
    assert_redirected_to retire_note_detail_path(assigns(:retire_note_detail))
  end

  test "should destroy retire_note_detail" do
    assert_difference('RetireNoteDetail.count', -1) do
      delete :destroy, id: @retire_note_detail
    end

    assert_redirected_to retire_note_details_path
  end
end
