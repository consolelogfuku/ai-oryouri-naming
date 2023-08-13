# frozen_string_literal: true

class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :self_introductiton, :string
  end
end
