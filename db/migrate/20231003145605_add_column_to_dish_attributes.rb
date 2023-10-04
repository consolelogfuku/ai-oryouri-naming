class AddColumnToDishAttributes < ActiveRecord::Migration[7.0]
  def change
    add_column :dish_attributes, :name_en, :string
  end
end
