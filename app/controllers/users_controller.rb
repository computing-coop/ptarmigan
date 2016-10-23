# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout 'staff', :except => :new
  before_action :authenticate_user!, :only => [:update,  :edit, :index]
  respond_to :html

  
  def edit
    @user = User.find(params[:id])
    if current_user == @user
      render :template => 'users/new'
    else
      flash[:error] = 'This is not you.'
      redirect_to users_path
    end
  end
      
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update_attributes(user_params)
        respond_with @user, location: admin_reports_path
      end
    else
      flash[:error] = 'This is not you.'
      redirect_to users_path
    end
  end
  
  protected
  
  def user_params
    params.require(:user).permit([:icon, :name, :email])
  end
end
