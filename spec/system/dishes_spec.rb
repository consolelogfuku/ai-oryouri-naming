require 'rails_helper'

RSpec.describe "Dishes", type: :system do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    before do
      visit root_path
    end
    describe '料理名の生成' do
      context 'フォームの入力値が正常' do
        it '料理名の生成が成功する' do
          fill_in 'generate_form[name_1]', with: 'にんじん'
          fill_in 'generate_form[name_2]', with: 'だいこん'
          fill_in 'generate_form[name_3]', with: '豚肉'
          find('label', text:'炒める').click # check('cooking_method_炒める')だとうまくいかない
          find('label', text:'さっぱり').click # choose 'seasoning_1'だとうまくいかない
          find('label', text:'ジューシー').click # choose 'texture_10'だとうまくいかない
          find('label', text:'和風').click # choose 'category_22'だとうまくいかない
          fill_in 'generate_form[point]', with: 'ゆっくり煮込む'
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          sleep(15) # 料理名が生成されるまで待機
          expect(page).to have_content('あなたの料理名は') # 料理名生成結果画面に遷移
          find_link('ログイン') # ログイン前のみ、ログインリンクを表示
        end
      end

      context '食材が未入力' do
        it '料理名の生成が失敗する' do
          fill_in 'generate_form[name_1]', with: ''
          fill_in 'generate_form[name_2]', with: ''
          fill_in 'generate_form[name_3]', with: ''
          find('label', text: '炒める').click
          find('label', text: 'さっぱり').click
          find('label', text: 'ジューシー').click
          find('label', text: '和風').click
          fill_in 'generate_form[point]', with: 'ゆっくり煮込む'
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          expect(page).to have_content('食材は一つ以上入力してください')
          expect(page).to have_content('名前をつけられませんでした')
          expect(current_path).to eq root_path
        end
      end

      context '食材が15文字より多い' do
        it '料理名の生成が失敗する' do
          fill_in 'generate_form[name_1]', with: 'にんじんにんじんにんじんにんじん' # 16文字
          fill_in 'generate_form[name_2]', with: 'だいこん'
          fill_in 'generate_form[name_3]', with: '豚肉'
          find('label', text: '炒める').click
          find('label', text: 'さっぱり').click
          find('label', text: 'ジューシー').click
          find('label', text: '和風').click
          fill_in 'generate_form[point]', with: 'ゆっくり煮込む'
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          expect(page).to have_content('食材は15文字以内で入力してください')
          expect(page).to have_content('名前をつけられませんでした')
          expect(current_path).to eq root_path
        end
      end

      context '調理法が未選択' do
        it '料理名の生成が失敗する' do
          fill_in 'generate_form[name_1]', with: 'にんじん'
          fill_in 'generate_form[name_2]', with: 'だいこん'
          fill_in 'generate_form[name_3]', with: '豚肉'
          # find('label', text: '炒める').click
          find('label', text: 'さっぱり').click
          find('label', text: 'ジューシー').click
          find('label', text: '和風').click
          fill_in 'generate_form[point]', with: 'ゆっくり煮込む'
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          expect(page).to have_content('調理法は一つ以上選択してください')
          expect(page).to have_content('名前をつけられませんでした')
          expect(current_path).to eq root_path
        end
      end

      context '味付けが未選択' do
        it '料理名の生成が失敗する' do
          fill_in 'generate_form[name_1]', with: 'にんじん'
          fill_in 'generate_form[name_2]', with: 'だいこん'
          fill_in 'generate_form[name_3]', with: '豚肉'
          find('label', text: '炒める').click
          # find('label', text: 'さっぱり').click
          find('label', text: 'ジューシー').click
          find('label', text: '和風').click
          fill_in 'generate_form[point]', with: 'ゆっくり煮込む'
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          expect(page).to have_content('味付けを入力してください')
          expect(page).to have_content('名前をつけられませんでした')
          expect(current_path).to eq root_path
        end
      end

      context '食感が未選択' do
        it '料理名の生成が失敗する' do
          fill_in 'generate_form[name_1]', with: 'にんじん'
          fill_in 'generate_form[name_2]', with: 'だいこん'
          fill_in 'generate_form[name_3]', with: '豚肉'
          find('label', text: '炒める').click
          find('label', text: 'さっぱり').click
          # find('label', text: 'ジューシー').click
          find('label', text: '和風').click
          fill_in 'generate_form[point]', with: 'ゆっくり煮込む'
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          expect(page).to have_content('食感を入力してください')
          expect(page).to have_content('名前をつけられませんでした')
          expect(current_path).to eq root_path
        end
      end

      context 'カテゴリーが未選択' do
        it '料理名の生成が失敗する' do
          fill_in 'generate_form[name_1]', with: 'にんじん'
          fill_in 'generate_form[name_2]', with: 'だいこん'
          fill_in 'generate_form[name_3]', with: '豚肉'
          find('label', text: '炒める').click
          find('label', text: 'さっぱり').click
          find('label', text: 'ジューシー').click
          # find('label', text: '和風').click
          fill_in 'generate_form[point]', with: 'ゆっくり煮込む'
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          expect(page).to have_content('カテゴリーを入力してください')
          expect(page).to have_content('名前をつけられませんでした')
          expect(current_path).to eq root_path
        end
      end

      context 'こだわりポイントが20文字より多い' do
        it '料理名の生成が失敗する' do
          fill_in 'generate_form[name_1]', with: 'にんじん'
          fill_in 'generate_form[name_2]', with: 'だいこん'
          fill_in 'generate_form[name_3]', with: '豚肉'
          find('label', text: '炒める').click
          find('label', text: 'さっぱり').click
          find('label', text: 'ジューシー').click
          find('label', text: '和風').click
          fill_in 'generate_form[point]', with: 'ゆっくり煮込むゆっくり煮込むゆっくり煮込む' # 21文字
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          expect(page).to have_content('こだわりポイントは20文字以内で入力してください')
          expect(page).to have_content('名前をつけられませんでした')
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      login(user)
      visit root_path
    end
    describe '料理名の生成' do
      context 'フォームの入力値が正常' do
        it '料理名の生成が成功する' do
          fill_in 'generate_form[name_1]', with: 'にんじん'
          fill_in 'generate_form[name_2]', with: 'だいこん'
          fill_in 'generate_form[name_3]', with: '豚肉'
          find('label', text:'炒める').click # check('cooking_method_炒める')だとうまくいかない
          find('label', text:'さっぱり').click # choose 'seasoning_1'だとうまくいかない
          find('label', text:'ジューシー').click # choose 'texture_10'だとうまくいかない
          find('label', text:'和風').click # choose 'category_22'だとうまくいかない
          fill_in 'generate_form[point]', with: 'ゆっくり煮込む'
          attach_file('generate_form[dish_image]', "#{Rails.root}/spec/factories/test.png")
          click_on 'AIに名前をつけてもらう'
          sleep(15) # 料理名が生成されるまで待機
          expect(page).to have_content('あなたの料理名は') # 料理名生成結果画面に遷移
          find_link('料理掲示板で公開する') # ログイン後のみ、掲示板公開リンクを表示
        end
      end
    end
  end
end
