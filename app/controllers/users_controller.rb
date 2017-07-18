class UsersController < ApplicationController

  before_action :require_no_user, only: [:new]
  before_action :require_user, only: [:show, :edit]
  before_action :set_user, only: [:edit, :update]

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

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: "Profile updated"
    else
      render :edit
    end
  end

  private
    def require_no_user
      redirect_to user_path(current_user), warning: "You are already logged in.  Logout first to create a new account." if current_user
    end

    def require_user
      redirect_to login_path, warning: "You must be logged in to do this." unless current_user
    end

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :username, :phone_number, :bio, :password)
    end
end
