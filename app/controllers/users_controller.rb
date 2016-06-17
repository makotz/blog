class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    @user = User.new user_params
    if @user.save
      redirect_to root_path, notice: "Success!"
    else
      redirect_to new_user_path, alert: "Unsuccessful!"
    end
  end

  def edit
    @user = User.find_by_id(session[:user_id])
  end

  def update
    @user = User.find_by_id(session[:user_id])
      if edit_account
        if @user.update user_params
          redirect_to root_path, notice: "Account Info Updated"
        else
          render :edit
        end
      elsif password_original? && password_diff? && password_correct?
        @user.update user_params
        redirect_to root_path, notice: "Password Updated"
      else
        render :edit, notice: "Password could not be updated"
      end
  end

  def reset
    @user = User.find_by_id(session[:user_id])
  end

  private

  def edit_account
    params.require(:user).permit(:first_name) != "" ||
    params.require(:user).permit(:last_name) != "" ||
    params.require(:user).permit(:email) != ""
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def password_correct?
      params[:current_password] == session[:user_id].password
  end

  def password_diff?
    params.require(:user).permit(:password) == params.require(:user).permit(:password_confirmation)
  end

  def password_original?
    params.require(:user).permit(:password) != session[:user_id].password
  end

end
