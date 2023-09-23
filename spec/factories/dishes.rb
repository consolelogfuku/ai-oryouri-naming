FactoryBot.define do
  factory :dish do
    association :user
    seasoning {DishAttribute.where(type: 'Seasoning').order("RANDOM()").first} # DBに保存されているものから、ランダムに並べ替えて、最初のものを選ぶ
    texture {DishAttribute.where(type: 'Texture').order("RANDOM()").first}
    category {DishAttribute.where(type: 'Category').order("RANDOM()").first}
    uuid {SecureRandom.uuid}
    dish_name {nil}
    point {"point"}
    dish_image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test.png')) }
    state {0}

    transient do # facotory内でモデルに存在していない属性を追加できるメソッド
      name_1 {nil}
      name_2 {nil}
      name_3 {nil}
      number_of_cooking_methods {1} # 調理法もデフォルトで1つとしておく
    end

    # dishをcreateした後に、食材と調理法を作成
      # transientの結果はevaluatorで取得できる
    before(:create) do |dish, evaluator|

      # 食材を作成する(値がnilでないかつDBに存在していない)
      unless evaluator.name_1 == nil || Ingredient.find_by(name: evaluator.name_1)
        ts = TinySegmenter.new
        create(:dishes_ingredient, dish: dish, ingredient: Ingredient.find_or_create_by(name: evaluator.name_1, morphemes: ts.segment(evaluator.name_1).join(',')))
      end

      unless evaluator.name_2 == nil || Ingredient.find_by(name: evaluator.name_2)
        ts = TinySegmenter.new
        create(:dishes_ingredient, dish: dish, ingredient: Ingredient.find_or_create_by(name: evaluator.name_2, morphemes: ts.segment(evaluator.name_1).join(',')))
      end

      unless evaluator.name_3 == nil || Ingredient.find_by(name: evaluator.name_3)
        ts = TinySegmenter.new
        create(:dishes_ingredient, dish: dish, ingredient: Ingredient.find_or_create_by(name: evaluator.name_3, morphemes: ts.segment(evaluator.name_1).join(',')))
      end
      
      # test用のDBのcooking_methodsテーブルから、指定した数だけランダムにデータを引っ張ってきて、dishと関連づける
      cooking_methods = CookingMethod.order("RANDOM()").limit(evaluator.number_of_cooking_methods)
      cooking_methods.each do |cooking_method|
        create(:dishes_cooking_method, dish: dish, cooking_method: cooking_method) # 関連も一緒に保存される
      end
    end

  end
end
