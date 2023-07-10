class UsersController < ApplicationController
    def show
      if logged_in?
        @user = User.find_by id: params[:id]
        return if @user

        flash[:warning] = "User not found!"
        redirect_to root_path
      else
        flash[:warning] = "You haven't logged in!"
        redirect_to root_path
      end
    end

    def new
      if logged_in? 
        redirect_to current_user
      else
        @user = User.new
      end
    end

    def create
      @user = User.new user_params
      if @user.save
        log_in @user
        flash[:success] = "User created successfully"
        redirect_to @user
      else
        render :new
      end
    end

    private

    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end    
end
