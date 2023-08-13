# frozen_string_literal: true

class CreateDishAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :dish_attributes do |t|
      t.string :type, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
