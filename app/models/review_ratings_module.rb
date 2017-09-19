module ReviewRatingsModule
  def average_review_rating
    reviews.average(:rating).to_f.round(1)
  end

  def half_star?
    rating = average_review_rating
    rating - rating.floor >= 0.2
  end
end
