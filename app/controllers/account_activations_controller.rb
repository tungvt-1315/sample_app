class AccountActivationsController < ApplicationController
  before_action :find_user, only: :edit

  def edit
    if @user && !@user.activated? && @user.authenticated?(:activation,
                                                          params[:id])
      @user.activate
      log_in @user
      flash[:success] = t "controller.users.activate.success"
      redirect_to @user
    else
      flash[:danger] = t "controller.users.activate.fail"
      redirect_to root_path
    end
  end

  private
  def find_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:warning] = t "controller.users.show.not_found"
    redirect_to root_path
  end
end
