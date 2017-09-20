class Users::ReviewsController < ApplicationController
  def new
    session[:return_to] = request.referer
    @new_review_presenter = NewReviewPresenter.new
  end

  def create
    reviewable = params["review"]
    if reviewable["reviewable_type"] == "wines"
      wine = Wine.find_or_create_by(code: reviewable["reviewable_id"]["code"] ) do |wine|
        wine.name = reviewable["reviewable_id"]["name"]
      end
      review = wine.reviews.create(review_params)
      wine.venues << Venue.find(review_params["venue_id"]) if review_params["venue_id"]
    else
      venue  = Venue.find(reviewable["reviewable_id"])
      review = venue.reviews.create(review_params)
    end
    if review.save
      review.report_review
      flash[:success] = "Review successfully submitted!"
      redirect_to session.delete(:return_to)
      Badge.badge_allocation(current_user)
    else
      redirect_to new_users_review_path(:reviewable_id => reviewable["reviewable_id"], :reviewable_type => reviewable["reviewable_type"])
    end
  end

  private
    def review_params
      (params["review"]["venue_id"] = Venue.find_by(name: params["review"]["venue"]).id) unless params["review"]["venue"].empty?
      params.require(:review).permit(:description, :rating, :user_id, :reviewable_id, :reviewable_type, :reviewable_params, :venue_id)
    end
end
