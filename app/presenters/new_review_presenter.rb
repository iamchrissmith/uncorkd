class NewReviewPresenter
  attr_reader :review, :venues

  def initialize
    @review = Review.new
    @venues = Venue.all
  end
end
