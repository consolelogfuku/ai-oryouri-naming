require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) } # ログインするために事前にuserを作成しておく

  describe 'ログイン前' do
    describe 'ユーザーの新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規登録が成功する' do
          visit sign_up_path
          fill_in 'user[name]', with: 'AIロボくん'
          fill_in 'user[email]', with: 'email@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('料理情報を入力しよう')
          expect(current_path).to eq root_path
        end
      end

      context 'ニックネームが未入力' do
        it 'ユーザーの新規登録が失敗する' do
          visit sign_up_path
          fill_in 'user[name]', with: ''
          fill_in 'user[email]', with: 'email@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('ニックネームを入力してください')
          expect(current_path).to eq sign_up_path
        end
      end

      context 'ニックネームが15文字より多い' do
        it 'ユーザーの新規登録が失敗する' do
          visit sign_up_path
          fill_in 'user[name]', with: 'AIロボくんAIロボくんAIロボくんAIロボくんAIロボくん'
          fill_in 'user[email]', with: 'email@example.com'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('ニックネームは15文字以内で入力してください')
          expect(current_path).to eq sign_up_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規登録が失敗する' do
          visit sign_up_path
          fill_in 'user[name]', with: 'AIロボくん'
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('メールアドレスを入力してください')
          expect(current_path).to eq sign_up_path
        end
      end

      context '登録済みのメールアドレスと使用' do
        it 'ユーザーの新規登録が失敗する' do
          existed_user = create(:user)
          visit sign_up_path
          fill_in 'user[name]', with: 'AIロボくん'
          fill_in 'user[email]', with: existed_user.email
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content('メールアドレスはすでに存在します')
          expect(current_path).to eq sign_up_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      login(user)
      expect(page).to have_content('料理情報を入力しよう') # Topページに遷移したことを確認してから、編集ページに遷移(こうしないと、処理が早すぎてログインが完了する前に編集ページに遷移しようとしてしまう)
      visit edit_profile_path
    end
    describe 'プロフィール編集' do
      context 'フォームの入力が正常' do
        it 'プロフィールの編集が成功する' do
          attach_file('user[avatar]', "#{Rails.root}/spec/factories/test.png")
          fill_in 'user[name]', with: 'updateロボくん'
          fill_in 'user[email]', with: 'update@example.com'
          click_on '更新'
          expect(find_field('user[name]').value).to eq 'updateロボくん' # フォームに値が入っているかチェック
          expect(find_field('user[email]').value).to eq 'update@example.com'
          expect(current_path).to eq edit_profile_path
        end
      end

      context 'ニックネームが未入力' do
        it 'プロフィールの編集が成功する' do
          attach_file('user[avatar]', "#{Rails.root}/spec/factories/test.png")
          fill_in 'user[name]', with: ''
          fill_in 'user[email]', with: 'update@example.com'
          click_on '更新'
          expect(page).to have_content('ニックネームを入力してください')
        end
      end

      context 'ニックネームが15文字より多い' do
        it 'プロフィールの編集が失敗する' do
          attach_file('user[avatar]', "#{Rails.root}/spec/factories/test.png")
          fill_in 'user[name]', with: 'AIロボくんAIロボくんAIロボくんAIロボくんAIロボくん'
          fill_in 'user[email]', with: 'update@example.com'
          click_button '更新'
          expect(page).to have_content('ニックネームは15文字以内で入力してください')
        end
      end

      context 'メールアドレスが未入力' do
        it 'プロフィールの編集が失敗する' do
          attach_file('user[avatar]', "#{Rails.root}/spec/factories/test.png")
          fill_in 'user[name]', with: 'updateロボくん'
          fill_in 'user[email]', with: ''
          click_on '更新'
          expect(page).to have_content('メールアドレスを入力してください')
        end
      end
    end
  end
end
