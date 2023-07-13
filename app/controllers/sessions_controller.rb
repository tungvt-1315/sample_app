# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    return unless logged_in?

    redirect_to current_user
  end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate(params.dig(:session, :password))
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t "invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
