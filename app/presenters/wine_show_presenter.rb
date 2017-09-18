class WineShowPresenter
  attr_reader :snooth_wine, :reviews, :venues
  def initialize(wine_code)
    @snooth_wine = SnoothWine.show_wine(wine_code)
    if wine_record
      @reviews = wine_reviews(wine_record)
      @venues = wine_venues(wine_record)
    end
  end

  def wine_record
    Wine.find_by(code: @snooth_wine.code)
  end

  def wine_reviews(wine_record)
    wine_record.reviews
  end

  def wine_venues(wine_record)
    wine_record.venues
  end
end
