class CreateVenueWines < ActiveRecord::Migration[5.1]
  def change
    create_table :venue_wines do |t|
      t.references :venue, foreign_key: true
      t.references :wine, foreign_key: true
    end
  end
end
