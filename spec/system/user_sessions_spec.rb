require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    before do
      visit login_path
    end
    context 'フォームの入力値が正常' do
      it 'ログインが成功する' do
        fill_in 'email', with: user.email
        fill_in 'password', with: 'password'
        click_on 'ログイン'
        expect(page).to have_content('ログインしました')
        expect(current_path).to eq root_path
      end
    end

    context 'メールアドレスが未入力' do
      it 'ログインが失敗する' do
        user
        fill_in 'email', with: ''
        fill_in 'password', with: 'password'
        click_on 'ログイン'
        expect(page).to have_content('ログインに失敗しました')
        expect(current_path).to eq login_path
      end
    end

    context 'パスワードが未入力' do
      it 'ログインが失敗する' do
        user
        fill_in 'email', with: user.email
        fill_in 'password', with: ''
        click_on 'ログイン'
        expect(page).to have_content('ログインに失敗しました')
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリックする' do
      it 'ログアウト処理が成功する' do
        login(user)
        expect(page).to have_content('ログインしました') # これを書かないと、ログインしてからトップページに遷移する前に、ドロップダウンをクリックしてしまう
        find('.header-dropdown-background').click
        click_link 'ログアウト'
        expect(page).to have_content('ログアウトしました')
        expect(current_path).to eq root_path
      end
    end
  end
end
