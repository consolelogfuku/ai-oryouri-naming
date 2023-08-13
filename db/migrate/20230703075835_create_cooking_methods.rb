# frozen_string_literal: true

class CreateCookingMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :cooking_methods do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
