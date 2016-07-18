class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "You're now signed up!"
    else
      render :new
    end
  end

  def edit
  end

  def update
      if @user.update user_params
        redirect_to user_path(@user), notice: "update successful"
      else
        render :edit
      end
  end

  def password_edit
    @user = current_user
  end

  def password_update
    @user = current_user
      user_params= params.require(:user).permit(:new_password, :password, :password_confirmation)
    if @user.authenticate(user_params[:password]) && @user.authenticate(user_params[:new_password]) == false
       @user.update(password: user_params[:new_password], password_confirmation: user_params[:password_confirmation])
       redirect_to root_path, notice: "Password updated"
    else
      if @user.authenticate(user_params[:password]) == false
        flash[:alert] = "Incorrect Password"
      elsif @user.authenticate(user_params[:new_password])
        flash[:alert] = "The new password should be different from the old password"
      else
      render :password_edit
      end
    end
  end

private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
      @user = User.find params[:id]
  end

end
