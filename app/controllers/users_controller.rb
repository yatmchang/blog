class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
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



private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
      @user = User.find params[:id]
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "please sign in" unless session[:user_id].present?
  end

end
