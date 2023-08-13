# frozen_string_literal: true

class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.belongs_to :seasoning, null: false # seasoningsテーブルは存在しないため、foreign_key: trueはつけられない
      t.belongs_to :texture, null: false # texturesテーブルは存在しないため、foreign_key: trueはつけられない
      t.belongs_to :category, null: false # categoriesテーブルは存在しないため、foreign_key: trueはつけられない
      t.string :uuid, null: false
      t.string :dish_name
      t.string :point
      t.string :dish_image
      t.integer :state, default: 0, null: false

      t.timestamps
    end
  end
end
