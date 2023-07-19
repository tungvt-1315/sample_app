# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include Pagy::Backend

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "controller.users.login_required"
    store_location
    redirect_to login_path
  end
end
