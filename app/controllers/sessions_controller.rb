class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      redirect_to root_path, notice: "Success"
    else
      render :new, alert: "Unsuccessful sign in"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end
end
