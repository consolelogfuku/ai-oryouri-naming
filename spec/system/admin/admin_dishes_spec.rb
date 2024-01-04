require 'rails_helper'

RSpec.describe 'AdminDishes', type: :system do
  let!(:dish) { create(:dish, name_1:'たまご', name_2:'たけのこ', name_3:'醤油', number_of_cooking_methods: 2) }

  before do
    admin_login
    expect(page).to have_content('ユーザー一覧')
    expect(page).to have_content('料理一覧')
    click_on '料理一覧'
  end
  describe '料理一覧での操作' do
    fit '料理一覧の確認ができる' do
      expect(page).to have_content(dish.dish_name)
      expect(page).to have_content(dish.user.name)
    end

    fit '料理詳細を確認できる' do
      click_link '詳細', href: admin_dish_path(dish.uuid)
      expect(page).to have_content(dish.dish_name)
      expect(page).to have_content(dish.ingredients.first.name)
      expect(page).to have_content(dish.cooking_methods.first.name)
      expect(current_path).to eq admin_dish_path(dish.uuid)
    end

    fit '料理を削除できる' do
      click_link '削除', href: admin_dish_path(dish.uuid)
      page.accept_alert '削除していいですか？' do
      end
      expect(page).not_to have_content(dish.dish_name)
      expect(page).not_to have_content(dish.user.name)
    end
  end

end
