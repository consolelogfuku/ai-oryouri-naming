class ChangeColumnToIngredient < ActiveRecord::Migration[7.0]
  def change
    remove_index :ingredients, :morphemes, unique: true
  end
end