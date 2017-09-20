class ChangeWinesTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :wines, "vintage"
    remove_column :wines, "varietal"
    remove_column :wines, "vineyard"
    remove_column :wines, "rating"
    remove_column :wines, "description"
    remove_index :wines, ["name"]
    add_column :wines, :code, :string
  end
end
