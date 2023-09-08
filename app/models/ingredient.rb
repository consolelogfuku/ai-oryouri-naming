class Ingredient < ApplicationRecord
  has_many :dishes_ingredients, dependent: :destroy
  has_many :dishes, through: :dishes_ingredients

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  validates :morphemes, presence: true # morphemesにはユニーク制約をつけない("キャベツ"・"きゃべつ"ともに形態素解析後は"きゃべつ"になるため)
end
