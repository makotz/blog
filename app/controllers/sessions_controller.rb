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

  # def create
  #   user = User.find_by_email(params[:email])
  #   if user && user.authenticate(params[:password])
  #     if params[:remember_me]
  #       cookies.permanent[:auth_token] = user.auth_token
  #     else
  #       cookies[:auth_token] = user.auth_token
  #     end
  #     redirect_to root_url, :notice => "Logged in!"
  #   else
  #     flash.now.alert = "Invalid email or password"
  #     render "new"
  #   end
  # end
  #
  # def destroy
  #   cookies.delete(:auth_token)
  #   redirect_to root_url, :notice => "Logged out!"
  # end

end
