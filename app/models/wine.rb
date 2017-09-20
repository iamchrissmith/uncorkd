class Wine < ApplicationRecord
  include ReviewRatingsModule

  validates_presence_of :name, :code

  has_many :venue_wines
  has_many :venues, through: :venue_wines
  has_many :reviews, as: :reviewable
  has_many :follows, as: :target
  has_many :followers, through: :follows

  def self.text_search(query)
    self.where("similarity(name, ?) > 0.15", query).order("similarity(name, #{ActiveRecord::Base.connection.quote(query)}) DESC")
  end

  def news_feed
    enricher = StreamRails::Enrich.new
    feed = StreamRails.feed_manager.get_news_feeds(id)[:wine]
    results = feed.get()['results']
    enricher.enrich_activities(results)
  end
end
