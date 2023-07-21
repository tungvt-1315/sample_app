# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create show)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def new
    return redirect_to current_user if logged_in?

    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_mail"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @page, @microposts = pagy @user.microposts.newest, item: 10
  end

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

  def destroy
    if @user.destroy
      flash[:success] = t "controller.users.delete.success"
    else
      flash[:danger] = t "controller.users.delete.fail"
    end
    redirect_to users_path
  end

  def index
    @pagy, @users = pagy User.all
  end

  def following
    @title = t "following"
    @pagy, @users = pagy(@user.following, items: 10)
    render :show_follow
  end

  def followers
    @title = t "followers"
    @pagy, @users = pagy(@user.followers, items: 10)
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "controller.users.show.not_found"
    redirect_to root_path
  end

  def correct_user
    return if current_user?(@user)

    flash[:danger] = t "controller.users.wrong_user"
    redirect_to root_path
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t "controller.users.not_admin"
    redirect_to root_path
  end
end
