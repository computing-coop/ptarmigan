# -*- encoding : utf-8 -*-
class UsersController < InheritedResources::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout 'staff', :except => :new
  before_filter :authenticate_user!, :only => [:update,  :edit, :index]
  actions :new, :create, :update, :edit, :index
  # # render new.rhtml
  #  def new
  #    @user = User.new
  #  end
 
  # def create
  #   logout_keeping_session!
  #   @user = User.new(params[:user])
  #   success = @user && @user.save
  #   if success && @user.errors.empty?
  #           # Protects against session fixation attacks, causes request forgery
  #     # protection if visitor resubmits an earlier form using back
  #     # button. Uncomment if you understand the tradeoffs.
  #     # reset session
  #     self.current_user = @user # !! now logged in
  #           redirect_back_or_default('/')
  #     flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
  #   else
  #     flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
  #     render :action => 'new'
  #   end
  # end

  
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
  
  def update
    update! { admin_reports_path }
  end
  
end
