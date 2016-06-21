class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Success!"
    else
      flash[:alert]= "Unsuccessful!"
      render new_user_path
    end
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def update
    @user = User.find_by_id(session[:user_id])
    if @user.update user_params
          redirect_to root_path, notice: "Account Info Updated"
        else
          render :edit
        end
  end

  def edit_password
    @user = User.find_by_id(session[:user_id])
  end

  def update_password
    @user = User.find_by_id(session[:user_id])
    if @user.authenticate(user_params[:current_password]) && @user.authenticate(user_params[:password]) == false
      @user.update(password: user_params[:password], password_confirmation: user_params[:password_confirmation])
      redirect_to root_path, notice: "Password Info Updated"
        else
        render :edit_password, alert: "Unsuccessful!"
        end
  end

  def forgot_password
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

end
