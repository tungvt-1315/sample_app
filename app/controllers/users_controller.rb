# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in?, only: :show
  before_action :load_user, only: :show

  def new
    return redirect_to current_user if logged_in?

    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controller.user.create.success"
      redirect_to @user
    else
      render :new
    end
  end

  def show; end

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
end
