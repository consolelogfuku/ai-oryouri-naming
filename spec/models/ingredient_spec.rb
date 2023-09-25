require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'varidation' do
    # 食材を3つDBにちゃんと保存できるか確認(dishの関連として生成)
    it 'is valid with all attributes' do
      dish = create(:dish, name_1: 'たまご', name_2: 'かつお', name_3: 'たまねぎ')
      expect(dish).to be_valid
      expect(dish.errors).to be_empty
    end

    # 食材なし
    it 'is invalid without name' do
      ingredient_without_name = build(:ingredient, name: '')
      expect(ingredient_without_name).to be_invalid
      expect(ingredient_without_name.errors.full_messages).to eq %w[食材を入力してください 形態素を入力してください]
    end

    # 食材が15文字以上の場合
    it 'is invalid name longer than 15 characters' do
      ingredient = build(:ingredient, name: 'あいうえおかきくけこさしすせそたちつてと')
      expect(ingredient).to be_invalid
      expect(ingredient.errors.full_messages).to eq ['食材は15文字以内で入力してください']
    end
  end
end
