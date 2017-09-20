class Admin::VenuesController < Admin::BaseController
  def index
    @venues = Venue.order('name').paginate(:page => params[:page], :per_page => 30)
  end

  def destroy
    Venue.find(params[:id]).destroy
    redirect_to admin_venues_path
  end
end
