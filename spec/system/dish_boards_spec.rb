require 'rails_helper'

RSpec.describe "DishBoards", type: :system do
  # 公開中の料理を生成する
  let(:dish) { create(:dish, state: 1) }
  let(:user) { create(:user) }
  # 作成したuserに紐づけられたdishを作成
  let(:user_dish) { create(:dish, user: user, state: 1) }

  describe 'ログイン前' do
    before do
      dish
      visit dishes_path
    end
    describe 'ページ遷移確認' do
      it 'みんなの料理一覧ページに遷移できる' do
        expect(page).to have_content('みんなの料理')
        expect(current_path).to eq dishes_path
      end

      it '公開されている料理詳細ページに遷移できる' do
        # 料理カードの料理名をクリック
        click_link dish.dish_name
        expect(page).to have_content(dish.dish_name)
        expect(current_path).to eq dish_path(dish.uuid)
      end

      it '公開されている料理を作成したユーザーの料理一覧ページに遷移できる' do
        find('.card-link').click
        expect(page).to have_content("#{dish.user.name}の料理")
        expect(current_path).to eq user_path(dish.user.uuid)
      end
    end
  end

  describe 'ログイン後' do
    before do
      login(user)
      user_dish
    end
    describe 'みんなの料理一覧で、自分の料理の編集・削除ができる' do
      it '料理編集ページへ遷移して、編集ができる' do
        visit dishes_path
        find('.crud-menus').click
        click_link '編集する'
        expect(page).to have_content('ステータス')
        expect(current_path).to eq edit_dish_path(user_dish.uuid)
        select('非公開', from: 'dish[state]') # ステータスを非公開にする
        attach_file('dish[dish_image]', "#{Rails.root}/spec/factories/test.png")
        click_on '更新'
        sleep 5
        expect(page).to have_content('更新しました')
        expect(current_path).to eq edit_dish_path(user_dish.uuid)
        expect(page).to have_select('ステータス', selected: '非公開') # セレクトボックスで「非公開」が選択されていることを確認
      end

      it 'みんなの料理一覧から、料理の削除ができる' do
        visit dishes_path
        find('.crud-menus').click
        click_link '削除する'
        page.accept_alert '削除してよいですか？' do; end
        expect(page).to have_content('削除しました')
        expect(page).to have_content('料理がありません')
      end
    end

    describe '他人の料理にいいねをする' do
      before do
        dish # 他人の料理を生成
      end
      it 'いいねができる' do
        visit dishes_path
        find('a[data-turbo-method="post"]').click # いいねボタンをクリック
        expect(page).to have_selector('a[data-turbo-method="delete"]') # 色のついたボタンに変化する
      end

      it 'いいねした料理一覧で、いいねした料理が表示される' do
        visit dishes_path
        find('a[data-turbo-method="post"]').click # いいねボタンをクリック
        expect(page).to have_selector('a[data-turbo-method="delete"]') # 色のついたボタンに変化する
        visit likes_dishes_path
        expect(page).to have_content(dish.dish_name)
        expect(page).to have_selector('a[data-turbo-method="delete"]') # いいねボタンが押されている
      end
    end

    describe '自分の料理一覧の「公開中」タグ' do
      it '掲示板に公開されている料理には、「公開中」タグがついている' do
      visit user_path(user.uuid)
      expect(page).to have_content("#{user.name}の料理")
      expect(page).to have_selector('.publish-mark') # 「公開中」タグがついているか確認
      end
    end
  end
end
