require 'rails_helper'

RSpec.describe 'AdminUsers', type: :system do
  let!(:user) { create(:user) }

  before do
    admin_login
    expect(page).to have_content('ユーザー一覧')
    expect(page).to have_content('料理一覧')
    click_on 'ユーザー一覧'
  end
  describe 'ユーザー一覧での操作' do
    it 'ユーザー一覧の確認ができる' do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.email)
    end

    it 'ユーザーの削除ができる' do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.email)
      click_link '削除', href: admin_user_path(user.uuid)
      page.accept_alert '削除して良いですか？' do  # ユーザーを削除
      end
      expect(page).not_to have_content(user.name)
      expect(page).not_to have_content(user.email)
    end
  end
end
