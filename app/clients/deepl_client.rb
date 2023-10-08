class DeeplClient
  def ingredients_to_en(ingredients)
    deepl_translate = DeepL.translate ingredients.pluck(:name).join(',').to_s, 'JA', 'EN'
    deepl_translate.text
  end

  def point_to_en(point)
    deepl_translate = DeepL.translate point.to_s, 'JA', 'EN'
    deepl_translate.text
  end
end
