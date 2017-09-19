class Venue < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip
  validates_uniqueness_of :name

  has_many :user_venues
  has_many :managers, through: :user_venues, source_type: "User"

  has_many :venue_wines
  has_many :wines, through: :venue_wines

  has_many :reviews, as: :reviewable
  has_many :follows, as: :target
  has_many :followers, through: :follows

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

  def news_feed
    enricher = StreamRails::Enrich.new
    feed = StreamRails.feed_manager.get_news_feeds(id)[:venue]
    results = feed.get(:limit=>5)['results']
    enricher.enrich_activities(results)
  end
end
