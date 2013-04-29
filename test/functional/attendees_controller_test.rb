# -*- encoding : utf-8 -*-
require 'test_helper'

class AttendeesControllerTest < ActionController::TestCase
  
  test 'create' do
    Attendee.any_instance.expects(:save).returns(true)
    @attendee = attendees(:basic)
    post :create, :attendee => @attendee.attributes
    assert_response :redirect
  end
  
  test 'create with failure' do
    Attendee.any_instance.expects(:save).returns(false)
    @attendee = attendees(:basic)
    post :create, :attendee => @attendee.attributes
    assert_template 'new'
  end
  
  test 'update' do
    Attendee.any_instance.expects(:save).returns(true)
    @attendee = attendees(:basic)
    put :update, :id => attendees(:basic).to_param, :attendee => @attendee.attributes
    assert_response :redirect
  end
  
  test 'update with failure' do
    Attendee.any_instance.expects(:save).returns(false)
    @attendee = attendees(:basic)
    put :update, :id => attendees(:basic).to_param, :attendee => @attendee.attributes
    assert_template 'edit'
  end
  
  test 'destroy' do
    Attendee.any_instance.expects(:destroy).returns(true)
    @attendee = attendees(:basic)
    delete :destroy, :id => @attendee.to_param
    assert_not_nil flash[:notice] 
    assert_response :redirect
  end
  
  # Not possible: destroy with failure
  
  test 'new' do
    get :new
    assert_response :success
  end
  
  test 'edit' do
    @attendee = attendees(:basic)
    get :edit, :id => @attendee.to_param
    assert_response :success
  end
  
  test 'show' do
    @attendee = attendees(:basic)
    get :show, :id => @attendee.to_param
    assert_response :success
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendees)
  end
  
end
