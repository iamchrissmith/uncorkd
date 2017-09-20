class AddVenueToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :venue, foreign_key: true
  end
end
