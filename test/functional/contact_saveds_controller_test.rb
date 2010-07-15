require 'test_helper'

class ContactSavedsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_saveds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_saved" do
    assert_difference('ContactSaved.count') do
      post :create, :contact_saved => { }
    end

    assert_redirected_to contact_saved_path(assigns(:contact_saved))
  end

  test "should show contact_saved" do
    get :show, :id => contact_saveds(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => contact_saveds(:one).to_param
    assert_response :success
  end

  test "should update contact_saved" do
    put :update, :id => contact_saveds(:one).to_param, :contact_saved => { }
    assert_redirected_to contact_saved_path(assigns(:contact_saved))
  end

  test "should destroy contact_saved" do
    assert_difference('ContactSaved.count', -1) do
      delete :destroy, :id => contact_saveds(:one).to_param
    end

    assert_redirected_to contact_saveds_path
  end
end
