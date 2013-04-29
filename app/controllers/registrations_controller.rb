class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    if Ptarmigan::ALLOWED_USERS.include?(params[:user][:email])
      super
    else
      flash[:error] = "Sorry, you aren't allowed to sign up for the Ptarmigan website."
      redirect_to '/'
    end
  end

  def update
    super
  end
end 