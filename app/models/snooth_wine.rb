class SnoothWine
  attr_reader :image,
              :name,
              :varietal,
              :vintage,
              :vineyard,
              :rating,
              :price,
              :code
  def initialize(attrs)
    @image = attrs[:image]
    @name = attrs[:name]
    @varietal = attrs[:varietal]
    @vintage = attrs[:vintage]
    @vineyard = attrs[:winery]
    @rating = attrs[:snoothrank]
    @price = attrs[:price]
    @code = attrs[:code]
  end

  def self.return_all
    raw_data = SnoothService.return_all
    raw_data.map do |raw_data|
      SnoothWine.new(raw_data)
    end
  end

  def self.show_wine(wine_code)
    raw_data = SnoothService.find_wine(wine_code).first
    SnoothWine.new(raw_data)
  end
end
