class User < ApplicationRecord
  has_secure_password

  validates_presence_of :first_name, :last_name, :username, :email, :phone_number, :country_code
  validates_uniqueness_of :username

  enum role: %w(member manager admin)
  enum status: %w(active inactive)

  has_many :user_venues, as: :manager, dependent: :destroy
  has_many :venues, through: :user_venues, dependent: :destroy

  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followed_venues, :through => :follows, :source => :target, :source_type => 'Venue', dependent: :destroy
  has_many :followed_wines, through: :follows, source: :target, source_type: 'Wine', dependent: :destroy


  def self.from_omniauth(auth)
    user = find_or_create_by(uid: auth[:uid]) do |user|
      user.uid            = auth["uid"]
      user.first_name     = auth["info"]["name"].split(" ").first
      user.last_name      = auth["info"]["name"].split(" ").last
      user.username       = auth["info"]["name"]
      user.email          = auth["info"]["email"]
      user.phone_number   = 0
      user.country_code   = 0
      user.password       = "password"
    end
  end

  def verified?
    verified
  end

  def name
    "#{first_name} #{last_name}"
  end

  def manager_has_venues_with_wine?(wine)
    !(venues & wine.venues).empty?
  end

  def followed(target)
    self.follows.where(target: target).first
  end

  def get_follow(target)
    follows.where(target: target)[0]
  end

  def followers
    Follow.where(target: self)
  end

  def news_feed
    enricher = StreamRails::Enrich.new
    feed = StreamRails.feed_manager.get_news_feeds(id)[:flat]
    results = feed.get()['results']
    enricher.enrich_activities(results)
  end
end
