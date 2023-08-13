# frozen_string_literal: true

class Ingredient < ApplicationRecord
  has_one :dish

  # 食材は15文字以内
  validates :name_1, length: { maximum: 15 }
  validates :name_2, length: { maximum: 15 }
  validates :name_3, length: { maximum: 15 }

  # カスタムメソッド
  validate :at_least_one_ingredient

  private

  def at_least_one_ingredient
    return unless name_1.blank? && name_2.blank? && name_3.blank?

    errors.add(:base, '食材は1つ以上入力してください')
  end
end
