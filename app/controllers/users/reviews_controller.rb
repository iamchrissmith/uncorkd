class Users::ReviewsController < ApplicationController
  def new
    session[:return_to] = request.referer
    @review = Review.new
  end

  def create
    reviewable = params["review"]
    if reviewable["reviewable_type"] == "wines"
      wine = Wine.find(reviewable["reviewable_id"])
      review = wine.reviews.create(review_params)
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
      render :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:description, :rating, :user_id, :reviewable_id, :reviewable_type)
    end
end
