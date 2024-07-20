class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        Rails.logger.debug "User params: #{user_params.inspect}"

        @user = User.new(user_params)
        
        if @user.save
            session[:user_id] = @user.id
            Rails.logger.debug "Session values: #{session.inspect}"
            redirect_to articles_path, notice: "Thank you for signing up!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
