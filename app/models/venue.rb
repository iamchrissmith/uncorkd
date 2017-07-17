class Venue < ApplicationRecord
  has_many :user_venues
  has_many :managers, through: :user_venues, source_type: "User"

  has_many :venue_wines
  has_many :wines, through: :venue_wines

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj) { obj.full_address.present? and obj.full_address_changed? }

  def full_address
    "#{street_address} #{city}, #{state} #{zip}"
  end

  def full_address_changed?
    return true if street_address_changed?
    return true if city_changed?
    return true if state_changed?
    return true if zip_changed?
    false
  end
end
