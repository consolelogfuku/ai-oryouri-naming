class StabilityClient
  def initialize
    @conn = Faraday.new(
      url: ENV['STABILITY_URL'],
      headers: {'Authorization' => ENV['STABILITY_API_KEY'],
                'Content-Type' => 'application/json',
                'Accept' => 'application/json'}
    )
  end

  def post_to_stability_api(ingredients_en, cooking_methods, seasoning, texture, category, point_en)

    body = {
      cfg_scale: 7,
      height: 512,
      width: 512,
      samples: 1,
      steps: 30,
      text_prompts: [
      {
      text: "#{ingredients_en}, #{cooking_methods.pluck(:name_en).join(',')}, #{seasoning.name_en}, #{texture.name_en}, #{category.name_en}, #{point_en}, high detail, food photography , Bokeh effect, on a plate",
      weight: 1
      }
      ]
    }
    response = @conn.post('', body.to_json)
    response_body = JSON.parse(response.body)
  end
end