require 'rails_helper'

RSpec.describe "ReviewRatingModule", type: :module do
  describe "instance_methods" do
    it "#average_review_rating returns average rating of wine/venue from reviews" do
      wine_1, wine_2 = create_list(:wine, 2)
      create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 5)
      create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 1)
      create(:review, reviewable_type: "Wine", reviewable_id: wine_1.id, rating: 3)

      create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 3)
      create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 4)
      create(:review, reviewable_type: "Wine", reviewable_id: wine_2.id, rating: 4)

      expect(wine_1.average_review_rating).to eq(3)
      expect(wine_2.average_review_rating).to eq(3.7)
    end

    it "#half_rating_star? returns true if decimal place of wine/venue rating is between .2 and .8" do
      venue_1, venue_2 = create_list(:venue, 2)
      create(:review, reviewable_type: "Venue", reviewable_id: venue_1.id, rating: 5)
      create(:review, reviewable_type: "Venue", reviewable_id: venue_1.id, rating: 1)
      create(:review, reviewable_type: "Venue", reviewable_id: venue_1.id, rating: 3)

      create(:review, reviewable_type: "Venue", reviewable_id: venue_2.id, rating: 3)
      create(:review, reviewable_type: "Venue", reviewable_id: venue_2.id, rating: 4)
      create(:review, reviewable_type: "Venue", reviewable_id: venue_2.id, rating: 4)

      expect(venue_1.half_star?).to eq(false)
      expect(venue_2.half_star?).to eq(true)
    end
  end
  end
