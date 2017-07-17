class CreateWines < ActiveRecord::Migration[5.1]
  def change
    create_table :wines do |t|
      t.string :name
      t.string :varietal
      t.string :vintage
      t.string :vineyard
      t.integer :rating
      t.text :description

      t.timestamps
    end
  end
end
