class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration,
                only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params.dig(:password_reset, :email)&.downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "check_mail"
      redirect_to root_path
    else
      flash.now[:danger] = t "cannot_find_email"
      render :new
    end
  end

  def update
    if user_params[:password].empty?
      @user.errors.add :password, t(".error")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update_column :reset_digest, nil
      flash[:success] = t "controller.users.password_reset.success"
      redirect_to @user
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "controller.users.show.not_found"
    redirect_to root_url
  end

  def valid_user
    return if @user.activated && @user.authenticated?(:reset, params[:id])

    flash[:danger] = t "controller.users.activate.fail"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "controller.users.password_reset.expire"
    redirect_to new_password_reset_url
  end
end
