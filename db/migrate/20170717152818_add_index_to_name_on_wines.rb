class AddIndexToNameOnWines < ActiveRecord::Migration[5.1]
  def change
    add_index :wines, :name
  end
end
