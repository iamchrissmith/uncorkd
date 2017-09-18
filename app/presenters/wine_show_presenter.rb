class WineShowPresenter
  attr_reader :snooth_wine, :reviews, :venues, :uncorked_wine
  def initialize(wine_code)
    @snooth_wine = SnoothWine.show_wine(wine_code)
    @uncorked_wine = Wine.find_by(code: @snooth_wine.code)
  end
end
