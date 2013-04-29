# -*- encoding : utf-8 -*-
require 'test_helper'

class VideohostsControllerTest < ActionController::TestCase

  test "should create videohost" do
    Videohost.any_instance.expects(:save).returns(true)
    post :create, :videohost => { }
    assert_response :redirect
  end

  test "should handle failure to create videohost" do
    Videohost.any_instance.expects(:save).returns(false)
    post :create, :videohost => { }
    assert_template "new"
  end

  test "should destroy videohost" do
    Videohost.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => videohosts(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy videohost" do
    Videohost.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => videohosts(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for videohost" do
    get :edit, :id => videohosts(:one).to_param
    assert_response :success
  end

  test "should get index for videohosts" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videohosts)
  end

  test "should get new for videohost" do
    get :new
    assert_response :success
  end

  test "should get show for videohost" do
    get :show, :id => videohosts(:one).to_param
    assert_response :success
  end

  test "should update videohost" do
    Videohost.any_instance.expects(:save).returns(true)
    put :update, :id => videohosts(:one).to_param, :videohost => { }
    assert_response :redirect
  end

  test "should handle failure to update videohost" do
    Videohost.any_instance.expects(:save).returns(false)
    put :update, :id => videohosts(:one).to_param, :videohost => { }
    assert_template "edit"
  end

end
