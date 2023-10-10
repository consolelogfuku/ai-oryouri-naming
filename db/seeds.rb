# 調理法
cooking_methods = %w[炒める 煮る 煮込む 炒め煮 揚げる 蒸す 蒸し焼き 焼く 和える グリル ロースト マリネ]
cooking_methods_en = %w[stir-fry simmer stew braise deep-fry steam steam&fry fry dress grill roast marinade]
cooking_methods.each_with_index do |cooking_method, i|
  CookingMethod.find_or_create_by(name: cooking_method, name_en: cooking_methods_en[i])
end

# 味付け
seasonings = %w[さっぱり こってり 甘辛 酸味 辛味 優しいだし ガーリック スパイシー バター]
seasonings.each do |seasoning|
  Seasoning.find_or_create_by(name: seasoning)
end

# # 味付け(英訳)
# seasonings_en = %w[light greasy sweet&spicy sour chili stock garlic spicy butter]
# seasonings_en.each_with_index do |seasoning_en, i|
#   seasoning_first_id = Seasoning.first.id
#   seasoning = Seasoning.find(seasoning_first_id + i)
#   seasoning.update(name_en: seasoning_en)
# end

# 食感
textures = %w[ジューシー ごろごろ ホロホロ やわらか とろっと もちもち ぷりぷり なめらか ねばねば サクサク シャキシャキ クリーミー]
textures.each do |texture|
  Texture.find_or_create_by(name: texture)
end

# # 食感(英訳)
# textures_en = %w[juicy substantial crumbly soft thick&smooth chewy plump smooth sticky crispy crisp creamy]
# textures_en.each_with_index do |textures_en, i|
#   texture_first_id = Texture.first.id
#   texture = Texture.find(texture_first_id + i)
#   texture.update(name_en: textures_en)
# end

# カテゴリー
categories = %w[和風 中華 洋風 韓国 フレンチ イタリアン エスニック インド 自己流]
categories.each do |category|
  Category.find_or_create_by(name: category)
end

# # カテゴリー(英訳)
# categories_en = %w[Japanese Chinese Western Korean French Italian Ethnic Indian Self-styled]
# categories_en.each_with_index do |categories_en, i|
#   category_first_id = Category.first.id
#   category = Category.find(category_first_id + i)
#   category.update(name_en: categories_en)
# end