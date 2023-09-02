class CreateDishIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :dish_ingredients do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
    add_index :dish_ingredients, [:dish_id, :ingredient_id], unique: true
  end
end
