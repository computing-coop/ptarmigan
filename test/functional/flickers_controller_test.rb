# -*- encoding : utf-8 -*-
require 'test_helper'

class FlickersControllerTest < ActionController::TestCase

  test "should create flickers" do
    Flickers.any_instance.expects(:save).returns(true)
    post :create, :flickers => { }
    assert_response :redirect
  end

  test "should handle failure to create flickers" do
    Flickers.any_instance.expects(:save).returns(false)
    post :create, :flickers => { }
    assert_template "new"
  end

  test "should destroy flickers" do
    Flickers.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => flickers(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy flickers" do
    Flickers.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => flickers(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for flickers" do
    get :edit, :id => flickers(:one).to_param
    assert_response :success
  end

  test "should get index for flickers" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flickers)
  end

  test "should get new for flickers" do
    get :new
    assert_response :success
  end

  test "should get show for flickers" do
    get :show, :id => flickers(:one).to_param
    assert_response :success
  end

  test "should update flickers" do
    Flickers.any_instance.expects(:save).returns(true)
    put :update, :id => flickers(:one).to_param, :flickers => { }
    assert_response :redirect
  end

  test "should handle failure to update flickers" do
    Flickers.any_instance.expects(:save).returns(false)
    put :update, :id => flickers(:one).to_param, :flickers => { }
    assert_template "edit"
  end

end
