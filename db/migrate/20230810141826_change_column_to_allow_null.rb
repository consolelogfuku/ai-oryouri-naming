class ChangeColumnToAllowNull < ActiveRecord::Migration[7.0]
  def up
    change_column :dishes, :uuid, :string, null: true
  end

  def down
    change_column :dishes, :uuid, :string, null: false
  end
end
