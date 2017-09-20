class VenueWinesController < ApplicationController

  before_action :set_wine

  def new
  end

  def create
    new_ids = params[:venue_wines][:venue_ids].select(&:presence)
    @wine.venues = @wine.venues + new_ids.map { |id| Venue.find(id) }
    redirect_to wine_path(@wine.code), success: "This wine has been successfully listed on your selected venues."
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
    @wine.venues = @wine.venues + venues_to_add.map { |id| Venue.find(id) }
    redirect_to wine_path(@wine.code), success: "The venues with this wine has been successfully updated."
  end

  private
    def set_wine
      if params[:wine_name]
        @wine = Wine.find_or_create_by(code: params[:wine_id]) do |wine|
          wine.name = params[:wine_name]
        end
      else
        @wine = Wine.find(params[:wine_id])
      end
    end
end
