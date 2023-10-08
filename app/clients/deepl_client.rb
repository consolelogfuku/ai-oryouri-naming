class DeeplClient
  def ingredients_to_en(ingredients)
    deepl_translate = DeepL.translate "#{ingredients.pluck(:name).join(',')}", 'JA', 'EN'
    ingredients_en = deepl_translate.text
  end

  def point_to_en(point)
    deepl_translate = DeepL.translate "#{point}", 'JA', 'EN'
    point_en = deepl_translate.text
  end
end