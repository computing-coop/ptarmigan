# -*- encoding : utf-8 -*-
class ApplicantsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @applicant = Applicant.new
  end
 
  def create
    flash[:notice] = nil
    flash[:error] = nil
    logout_keeping_session!
    @applicant = Applicant.new(params[:applicant])
    if verify_recaptcha(:model => @applicant, :message => "Sorry, you have entered an incorrect CAPTCHA.")
      success = @applicant && @applicant.save
    end
    if success && @applicant.errors.empty?
      flash[:notice] = "Account created; verification email sent!"
      render :template => 'applicant_mailer/signedup'
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (see below)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    applicant = Applicant.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && applicant && !applicant.active?
      applicant.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/air/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a applicant with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
end
