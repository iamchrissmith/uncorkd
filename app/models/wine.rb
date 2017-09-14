class Wine < ApplicationRecord
  validates_presence_of :name, :vintage, :rating
  validates_uniqueness_of :name

  has_many :venue_wines
  has_many :venues, through: :venue_wines
  has_many :reviews, as: :reviewable
  has_many :follows, as: :target
  has_many :followers, through: :follows
  def self.text_search(query)
    self.where("similarity(name, ?) > 0.15", query).order("similarity(name, #{ActiveRecord::Base.connection.quote(query)}) DESC")
  end
end
