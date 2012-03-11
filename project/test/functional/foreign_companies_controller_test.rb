require 'test_helper'

class ForeignCompaniesControllerTest < ActionController::TestCase
  setup do
    @foreign_company = foreign_companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foreign_companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create foreign_company" do
    assert_difference('ForeignCompany.count') do
      post :create, foreign_company: @foreign_company.attributes
    end

    assert_redirected_to foreign_company_path(assigns(:foreign_company))
  end

  test "should show foreign_company" do
    get :show, id: @foreign_company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @foreign_company
    assert_response :success
  end

  test "should update foreign_company" do
    put :update, id: @foreign_company, foreign_company: @foreign_company.attributes
    assert_redirected_to foreign_company_path(assigns(:foreign_company))
  end

  test "should destroy foreign_company" do
    assert_difference('ForeignCompany.count', -1) do
      delete :destroy, id: @foreign_company
    end

    assert_redirected_to foreign_companies_path
  end
end
