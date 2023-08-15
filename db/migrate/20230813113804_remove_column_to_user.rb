class RemoveColumnToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :self_introductiton, :string
  end
end
