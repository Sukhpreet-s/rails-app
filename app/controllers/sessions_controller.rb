class SessionsController < ApplicationController
  def new
  end

  def create
    Rails.logger.debug "Session create params #{params.inspect}"
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    @_current_user = nil
    redirect_to root_path, notice: "Logged out successfully"
  end

  private
    def login_params
      params.permit(:email, :password)
    end
end
