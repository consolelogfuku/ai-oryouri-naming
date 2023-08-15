class AddUniqueIndexToCookingMethodsName < ActiveRecord::Migration[7.0]
  def change
    add_index :cooking_methods, :name, unique: true # 念の為重複しないようにする
  end
end
