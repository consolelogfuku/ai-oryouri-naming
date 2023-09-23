require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe 'varidation' do
    # 全部ちゃんと入力
    it 'is valid with all attributes' do
      dish = create(:dish)
      expect(dish).to be_valid
      expect(dish.errors).to be_empty
    end

    # 味付けがない
    it 'is invalid without seasoning' do
      dish_without_seasoning = build(:dish, seasoning_id: '')
      expect(dish_without_seasoning).to be_invalid
      expect(dish_without_seasoning.errors.full_messages).to eq ['味付けを入力してください']
    end

    # 食感がない
    it 'is invalid without texture' do
      dish_without_texture = build(:dish, texture_id: '')
      expect(dish_without_texture).to be_invalid
      expect(dish_without_texture.errors.full_messages).to eq ['食感を入力してください']
    end

    # カテゴリーがない
    it 'is invalid without texture' do
      dish_without_texture = build(:dish, category_id: '')
      expect(dish_without_texture).to be_invalid
      expect(dish_without_texture.errors.full_messages).to eq ['カテゴリーを入力してください']
    end
  end

  # こだわりポイントが20文字より多い
  it 'is invalid with point longer than 20 characters' do
    dish_with_longer_point = build(:dish, point:'ポイントポイントポイントポイントポイントポイント')
    expect(dish_with_longer_point).to be_invalid
    expect(dish_with_longer_point.errors.full_messages).to eq ['こだわりポイントは20文字以内で入力してください']
  end

end
