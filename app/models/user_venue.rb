class UserVenue < ApplicationRecord
  belongs_to :manager, polymorphic: true
  belongs_to :venue
end
