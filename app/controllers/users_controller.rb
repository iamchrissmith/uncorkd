class UsersController < ApplicationController

  before_action :require_no_user, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      ConfirmationSender.send_confirmation_to(@user)
      session[:user_id] = @user.id
      
      redirect_to twilio_confirmation_path

    else
      render :new
    end
  end

  def show
  end

  private
    def require_no_user
      redirect_to user_path(current_user), warning: "You are already logged in.  Logout first to create a new account." if current_user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :username, :phone_number, :bio, :password)
    end
end
