class SessionsController < ApplicationController
  def new; end

  def create
    if request.env["omniauth.auth"]
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user && @user.active?
        session[:user_id] = @user.id
        redirect_to root_path
      elsif @user && @user.inactive?
        flash[:error] =  "Sorry, this account has been deactivated."
        render :new
      end
    elsif URI(request.referer).path == login_path
      @user = User.find_by(username: params[:session][:username])
      if @user && @user.authenticate(params[:session][:password]) && @user.active?
        session[:user_id] = @user.id
        redirect_to root_path
      elsif @user && @user.authenticate(params[:session][:password]) && @user.inactive?
        flash[:error] = "Sorry, this account has been deactivated."
        render :new
      else
        flash[:error] = "Incorrect Login information, try again"
        render :new
      end
    elsif @user && @user.authenticate(params[:session][:password]) && @user.inactive?
      flash[:error] = "Sorry, this account has been deactivated."
      render :new
    else
      flash[:error] = "Incorrect Login information, try again"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = "Successfully Logged out"
    redirect_to login_path
  end
end
