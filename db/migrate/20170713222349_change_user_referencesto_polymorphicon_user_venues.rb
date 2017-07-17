class ChangeUserReferencestoPolymorphiconUserVenues < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_venues, :user_id
    add_column :user_venues, :manager_id, :integer
    add_column :user_venues, :manager_type, :string
  end
end
