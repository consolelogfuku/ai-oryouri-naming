class Ingredient < ApplicationRecord
  has_one :dish

  # カスタムメソッド
  validate :at_least_one_ingredient

  private
  
  def at_least_one_ingredient
    if name_1.blank? && name_2.blank? && name_3.blank?
      errors.add(:base, "食材は一つ以上入力してください")
    end
  end
end
