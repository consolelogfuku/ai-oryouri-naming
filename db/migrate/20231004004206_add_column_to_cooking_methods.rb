class AddColumnToCookingMethods < ActiveRecord::Migration[7.0]
  def change
    add_column :cooking_methods, :name_en, :string
    add_index :cooking_methods, :name_en, unique: true
  end
end
