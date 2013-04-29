# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe ChattersController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Chatter.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Chatter.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(chatter_url(assigns[:chatter]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Chatter.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Chatter.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Chatter.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Chatter.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Chatter.first
    response.should redirect_to(chatter_url(assigns[:chatter]))
  end

  it "show action should render show template" do
    get :show, :id => Chatter.first
    response.should render_template(:show)
  end
end
