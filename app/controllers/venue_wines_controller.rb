class VenueWinesController < ApplicationController

  before_action :set_wine

  def new
  end

  def create
    new_ids = params[:venue_wines][:venue_ids].select(&:presence)
    @wine.venues = @wine.venues + new_ids.map { |id| Venue.find(id) }
    redirect_to wine_path(@wine), success: "This wine has been successfully listed on your selected venues."
  end

  def edit
  end

  def update
    if params[:venue_wines]
      kept_ids = params[:venue_wines][:venue_ids].select(&:presence).map(&:to_i)
    else
      kept_ids = []
    end
    all_managed_venues = current_user.venues.pluck(:id)
    venues_to_delete = all_managed_venues - kept_ids
    venues_to_add = kept_ids - @wine.venues.pluck(:id)
    @wine.venue_wines.where(venue_id: venues_to_delete).destroy_all
    # binding.pry
    @wine.venues = @wine.venues + venues_to_add.map { |id| Venue.find(id) }
    redirect_to wine_path(@wine), success: "The venues with this wine has been successfully updated."
  end

  private
    def set_wine
      @wine = Wine.find(params[:wine_id])
    end

    # def venue_wines_params
    #   params.permit(:venue_wines)
    # end
end
