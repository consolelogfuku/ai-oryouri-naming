# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name_1
      t.string :name_2
      t.string :name_3

      t.timestamps
    end
  end
end
