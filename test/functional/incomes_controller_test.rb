# -*- encoding : utf-8 -*-
require 'test_helper'

class IncomesControllerTest < ActionController::TestCase

  test "should create income" do
    Income.any_instance.expects(:save).returns(true)
    post :create, :income => { }
    assert_response :redirect
  end

  test "should handle failure to create income" do
    Income.any_instance.expects(:save).returns(false)
    post :create, :income => { }
    assert_template "new"
  end

  test "should destroy income" do
    Income.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => incomes(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy income" do
    Income.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => incomes(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for income" do
    get :edit, :id => incomes(:one).to_param
    assert_response :success
  end

  test "should get index for incomes" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incomes)
  end

  test "should get new for income" do
    get :new
    assert_response :success
  end

  test "should get show for income" do
    get :show, :id => incomes(:one).to_param
    assert_response :success
  end

  test "should update income" do
    Income.any_instance.expects(:save).returns(true)
    put :update, :id => incomes(:one).to_param, :income => { }
    assert_response :redirect
  end

  test "should handle failure to update income" do
    Income.any_instance.expects(:save).returns(false)
    put :update, :id => incomes(:one).to_param, :income => { }
    assert_template "edit"
  end

end
