class DropIngredients < ActiveRecord::Migration[7.0]
  def change
    drop_table :ingredients
  end
end
