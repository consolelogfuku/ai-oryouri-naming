class RemoveColumnToDishes < ActiveRecord::Migration[7.0]
  def change
    remove_index :dishes, column: :ingredient_id
    remove_column :dishes, :ingredient_id, :string
  end
end
