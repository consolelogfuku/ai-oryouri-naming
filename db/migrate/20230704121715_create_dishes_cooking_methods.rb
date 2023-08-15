class CreateDishesCookingMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes_cooking_methods do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :cooking_method, null: false, foreign_key: true

      t.timestamps
    end
    add_index :dishes_cooking_methods, %i[dish_id cooking_method_id], unique: true # 重複を許さない
  end
end
