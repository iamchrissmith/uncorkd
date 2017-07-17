class VenueWine < ApplicationRecord
  belongs_to :wine
  belongs_to :venue
end
