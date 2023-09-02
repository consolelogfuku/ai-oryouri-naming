class ChangeColumnToIngredients < ActiveRecord::Migration[7.0]
  def change
    add_index :ingredients, :name, unique: true
    add_index :ingredients, :morphemes, unique: true
  end
end
