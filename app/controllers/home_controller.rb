class HomeController < ApplicationController

  def show
    if current_user && current_user.manager?
      redirect_to user_path(current_user)
    elsif current_user && current_user.member?
      redirect_to users_profile_path
    elsif current_user && current_user.admin?
      redirect_to admin_dashboard_path
    end
  end
end
