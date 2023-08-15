class ChangeColumnToUsers < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :uuid, :string, null: true
    add_index :users, :uuid, unique: true
  end

  def down
    change_column :users, :uuid, :string, null: false
  end
end
