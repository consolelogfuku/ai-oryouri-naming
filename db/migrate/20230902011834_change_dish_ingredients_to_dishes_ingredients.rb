class ChangeDishIngredientsToDishesIngredients < ActiveRecord::Migration[7.0]
  def change
    rename_table :dish_ingredients, :dishes_ingredients
  end
end
