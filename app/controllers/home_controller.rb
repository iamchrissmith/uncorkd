class HomeController < ApplicationController

  def show
    if current_user && current_user.manager?
      redirect_to user_path(current_user)
    end
  end

end
