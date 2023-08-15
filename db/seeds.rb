10.times do |n|
  User.create!(
    name: "テストユーザー#{n + 1}",
    email: "test#{n + 1}@test"
  )
end

# 調理法
cooking_methods = %w[炒める 煮る 煮込む 炒め煮 揚げる 蒸す 蒸し焼き 焼く 和える グリル ロースト マリネ]

cooking_methods.each do |cooking_method|
  CookingMethod.find_or_create_by(name: cooking_method)
end

# 味付け
seasonings = %w[さっぱり こってり 甘辛 酸味 辛味 優しいだし ガーリック スパイシー バター]
seasonings.each do |seasoning|
  Seasoning.find_or_create_by(name: seasoning)
end

# 食感
textures = %w[ジューシー ごろごろ ホロホロ やわらか とろっと もちもち ぷりぷり なめらか ねばねば サクサク シャキシャキ クリーミー]
textures.each do |texture|
  Texture.find_or_create_by(name: texture)
end

# カテゴリー
categories = %w[和風 中華 洋風 韓国 フレンチ イタリアン エスニック インド 自己流]
categories.each do |category|
  Category.find_or_create_by(name: category)
end
