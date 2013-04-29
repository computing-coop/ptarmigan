# -*- encoding : utf-8 -*-
require 'test_helper'

class AirformsControllerTest < ActionController::TestCase
  
  test 'create' do
    Airform.any_instance.expects(:save).returns(true)
    @airform = airforms(:basic)
    post :create, :airform => @airform.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Airform.any_instance.expects(:save).returns(false)
    @airform = airforms(:basic)
    post :create, :airform => @airform.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Airform.any_instance.expects(:save).returns(true)
    @airform = airforms(:basic)
    put :update, :id => airforms(:basic).to_param, :airform => @airform.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Airform.any_instance.expects(:save).returns(false)
    @airform = airforms(:basic)
    put :update, :id => airforms(:basic).to_param, :airform => @airform.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Airform.any_instance.expects(:destroy).returns(true)
    @airform = airforms(:basic)
    delete :destroy, :id => @airform.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    @airform = airforms(:basic)
    get :edit, :id => @airform.to_param
    assert_response :success
  end
  
  test 'show' do
    @airform = airforms(:basic)
    get :show, :id => @airform.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:airforms)
  end
  
end
