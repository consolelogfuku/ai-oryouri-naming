# frozen_string_literal: true

class AddIndexDishesUuid < ActiveRecord::Migration[7.0]
  def change
    add_index :dishes, :uuid, unique: true
  end
end
