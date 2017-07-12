class TwilioConfirmationController < ApplicationController

  def new

  end

  def create
    if current_user.is_valid_code?(code_params[:code])
      session[:authenticated] = true
      flash["success"] = "Logged in as #{current_user.username}."
      user_redirect(current_user)
    else
      flash.now[:danger] = "Invalid code. Please try again"
      render :new
    end
  end

  private

  def code_params
    params.require(:code_verification).permit(:code)
  end

end