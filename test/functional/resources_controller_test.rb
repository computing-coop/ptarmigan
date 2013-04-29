# -*- encoding : utf-8 -*-
require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  
  test 'create' do
    Resource.any_instance.expects(:save).returns(true)
    @resource = resources(:basic)
    post :create, :resource => @resource.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Resource.any_instance.expects(:save).returns(false)
    @resource = resources(:basic)
    post :create, :resource => @resource.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Resource.any_instance.expects(:save).returns(true)
    @resource = resources(:basic)
    put :update, :id => resources(:basic).to_param, :resource => @resource.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Resource.any_instance.expects(:save).returns(false)
    @resource = resources(:basic)
    put :update, :id => resources(:basic).to_param, :resource => @resource.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Resource.any_instance.expects(:destroy).returns(true)
    @resource = resources(:basic)
    delete :destroy, :id => @resource.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    @resource = resources(:basic)
    get :edit, :id => @resource.to_param
    assert_response :success
  end
  
  test 'show' do
    @resource = resources(:basic)
    get :show, :id => @resource.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:resources)
  end
  
end
