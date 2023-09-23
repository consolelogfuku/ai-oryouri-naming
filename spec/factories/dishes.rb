FactoryBot.define do
  factory :dish do
    association :user
    seasoning {DishAttribute.where(type: 'Seasoning').order("RANDOM()").first} # ランダムに選んだものの中から最初のものを選ぶ
    texture {DishAttribute.where(type: 'Texture').order("RANDOM()").first}
    category {DishAttribute.where(type: 'Category').order("RANDOM()").first}
    uuid {SecureRandom.uuid}
    dish_name {nil}
    point {"point"}
    dish_image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test.png')) }
    state {0}

    transient do # facotory内でモデルに存在していない属性を追加できるメソッド
      number_of_ingredients {1} # 食材数はデフォルトで1つとしておく
      number_of_cooking_methods {1} # 調理法もデフォルトで1つとしておく
    end

    # dishをcreateした後に、食材と調理法を作成
      # transientの結果はevaluatorで取得できる
    after(:create) do |dish, evaluator|
      # test用のDBのingredientsテーブルから、指定した数だけランダムにデータを引っ張ってきて、dishと関連づける
        # order("RANDOM()")でランダムな順序でレコードを取得する
      ingredients = Ingredient.order("RANDOM()").limit(evaluator.number_of_ingredients)
      ingredients.each do |ingredient|
        create(:dishes_ingredient, dish: dish, ingredient: ingredient) # 関連も一緒に保存される
      end
      
      # test用のDBのcooking_methodsテーブルから、指定した数だけランダムにデータを引っ張ってきて、dishと関連づける
      cooking_methods = CookingMethod.order("RANDOM()").limit(evaluator.number_of_cooking_methods)
      cooking_methods.each do |cooking_method|
        create(:dishes_cooking_method, dish: dish, cooking_method: cooking_method) # 関連も一緒に保存される
      end
    end
  end
end
