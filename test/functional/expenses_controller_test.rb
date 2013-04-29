# -*- encoding : utf-8 -*-
require 'test_helper'

class ExpensesControllerTest < ActionController::TestCase

  test "should create expense" do
    Expense.any_instance.expects(:save).returns(true)
    post :create, :expense => { }
    assert_response :redirect
  end

  test "should handle failure to create expense" do
    Expense.any_instance.expects(:save).returns(false)
    post :create, :expense => { }
    assert_template "new"
  end

  test "should destroy expense" do
    Expense.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => expenses(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy expense" do
    Expense.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => expenses(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for expense" do
    get :edit, :id => expenses(:one).to_param
    assert_response :success
  end

  test "should get index for expenses" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expenses)
  end

  test "should get new for expense" do
    get :new
    assert_response :success
  end

  test "should get show for expense" do
    get :show, :id => expenses(:one).to_param
    assert_response :success
  end

  test "should update expense" do
    Expense.any_instance.expects(:save).returns(true)
    put :update, :id => expenses(:one).to_param, :expense => { }
    assert_response :redirect
  end

  test "should handle failure to update expense" do
    Expense.any_instance.expects(:save).returns(false)
    put :update, :id => expenses(:one).to_param, :expense => { }
    assert_template "edit"
  end

end
