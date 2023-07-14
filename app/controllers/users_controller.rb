# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :load_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    return redirect_to current_user if logged_in?

    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controller.users.create.success"
      redirect_to @user
    else
      render :new
    end
  end

  def show; end

  def edit
    return if @user
    flash[:warning] = t "controller.users.show.not_found"
    redirect_to root_path
  end

  def update
    if @user.update user_params
      flash[:success] = t "controller.users.update.success"
      redirect_to current_user
    else
      render :edit
    end
  end

  def index
    @pagy, @users = pagy User.all
  end
  

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "controller.users.show.not_found"
    redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "controller.users.login_required"
      store_location
      redirect_to login_path  
    end    
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t"controller.users.wrong_user"
    redirect_to root_path
  end
end
