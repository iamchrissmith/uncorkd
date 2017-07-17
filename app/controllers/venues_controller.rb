class VenuesController < ApplicationController

  before_action :set_venue, only: [:show]

  def index
    @venues = Venue.paginate(:page => params[:page], :per_page => 30)
  end

  def show
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = current_user.venues.create(venue_params)

    if @venue.save
      redirect_to @venue, success: "Venue Successfully Created"
    else
      render :new
    end
  end

  private
    def venue_params
      params.require(:venue).permit(:name, :street_address, :city, :state, :zip)
    end

    def set_venue
      @venue = Venue.find(params[:id])
    end
end
