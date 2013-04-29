# -*- encoding : utf-8 -*-
require 'test_helper'

class VideosControllerTest < ActionController::TestCase

  test "should create video" do
    Video.any_instance.expects(:save).returns(true)
    post :create, :video => { }
    assert_response :redirect
  end

  test "should handle failure to create video" do
    Video.any_instance.expects(:save).returns(false)
    post :create, :video => { }
    assert_template "new"
  end

  test "should destroy video" do
    Video.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => videos(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy video" do
    Video.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => videos(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for video" do
    get :edit, :id => videos(:one).to_param
    assert_response :success
  end

  test "should get index for videos" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should get new for video" do
    get :new
    assert_response :success
  end

  test "should get show for video" do
    get :show, :id => videos(:one).to_param
    assert_response :success
  end

  test "should update video" do
    Video.any_instance.expects(:save).returns(true)
    put :update, :id => videos(:one).to_param, :video => { }
    assert_response :redirect
  end

  test "should handle failure to update video" do
    Video.any_instance.expects(:save).returns(false)
    put :update, :id => videos(:one).to_param, :video => { }
    assert_template "edit"
  end

end
