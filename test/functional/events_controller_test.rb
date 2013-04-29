# -*- encoding : utf-8 -*-
require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  test "should create event" do
    Event.any_instance.expects(:save).returns(true)
    post :create, :event => { }
    assert_response :redirect
  end

  test "should handle failure to create event" do
    Event.any_instance.expects(:save).returns(false)
    post :create, :event => { }
    assert_template "new"
  end

  test "should destroy event" do
    Event.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => events(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy event" do
    Event.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => events(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for event" do
    get :edit, :id => events(:one).to_param
    assert_response :success
  end

  test "should get index for events" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new for event" do
    get :new
    assert_response :success
  end

  test "should get show for event" do
    get :show, :id => events(:one).to_param
    assert_response :success
  end

  test "should update event" do
    Event.any_instance.expects(:save).returns(true)
    put :update, :id => events(:one).to_param, :event => { }
    assert_response :redirect
  end

  test "should handle failure to update event" do
    Event.any_instance.expects(:save).returns(false)
    put :update, :id => events(:one).to_param, :event => { }
    assert_template "edit"
  end

end
