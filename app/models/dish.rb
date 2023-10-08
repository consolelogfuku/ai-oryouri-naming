class Dish < ApplicationRecord
  
  before_create -> { self.uuid = SecureRandom.uuid }
  # レコード新規作成時のみ、generateメソッドを実行する
  after_commit :generate_dish_name, on: :create

  mount_uploader :dish_image, DishImageUploader

  belongs_to :user
  belongs_to :seasoning
  belongs_to :texture
  belongs_to :category
  has_many :dishes_cooking_methods, dependent: :destroy
  has_many :cooking_methods, through: :dishes_cooking_methods
  has_many :dishes_ingredients, dependent: :destroy
  has_many :ingredients, through: :dishes_ingredients
  has_many :likes, dependent: :destroy
  enum state: { draft: 0, published: 1 }

  validates :point, length: { maximum: 20 } # 20文字以内
  validates :state, presence: true

  # urlにuuidを使用
  def to_param
    uuid
  end

  # 似た料理を計算(形態素解析結果をもとに、ジャッカード係数を算出)
  def similar_dish
    # 比較元の形態素解析結果を格納
    @source = []
    # 比較先の形態素解析結果を格納
    @target = []
    # 最も大きいジャッカード係数を格納
    @highest = 0
    # 最も大きいジャッカード係数をもつdishを格納
    @highest_dish = nil

    # 比較元の料理の食材の形態素解析結果を配列に格納する(source)
    source_morphemes_to_array

    # DBに保存してある料理(公開済みのもののみ)の食材の形態素解析結果を配列に格納(target)し、比較元(source)とのジャッカード係数を求める
    @dishes = Dish.includes(:ingredients).where(state: 'published')
    @dishes.each do |dish|
      # 自分自身(source)とは比較しない
      next if dish == self

      # DBに保存してある料理(公開済みのもののみ)の食材の形態素解析結果を配列に格納
      target_morphemes_to_array(dish)

      # ジャッカード係数を求める
      calculate_jaccard_index

      # 一番大きいジャッカード係数を探して、その料理情報を取得する
      find_dish_with_highest_jaccard(dish)
    end
    # highest_dishが見つかった場合のみ、関連情報も読み込む(見つからなかった場合、関連情報を使用しないので無駄になる)
    @highest_dish = Dish.includes(:user).find(@highest_dish.id) if @highest_dish

    @highest_dish
  end

  # 料理写真を生成する
  def generate_dish_image
    # 食材とポイントをDeepL APIで英訳する
    deepl_client = DeeplClient.new
    ingredients_en = deepl_client.ingredients_to_en(ingredients)
    point_en = deepl_client.point_to_en(point)

    # 料理情報をリクエストボディに含めて、StabilityAI APIに問い合わせる
    stability_client = StabilityClient.new
    response_body = stability_client.post_to_stability_api(ingredients_en, cooking_methods, seasoning, texture, category, point_en)

    # base64形式の画像データをデコードし、pngで保存する
    image = Base64.decode64(response_body["artifacts"][0]["base64"]) # base64の値のみを取り出し
    file = Tempfile.new(['', '.png'])
    file.binmode
    file << image
    file.rewind
    
    self.dish_image = file
  end

  private

  # 料理名を生成する
  def generate_dish_name
    openai_client = OpenaiClient.new
    response = openai_client.generate_dish_name(ingredients, cooking_methods, seasoning, texture, category, point)
    # レスポンスから料理名を取得(シングル・ダブルクオーテーション、鉤括弧が含まれることがあるため、あらかじめ削除しておく)
    self.dish_name = response.dig('choices', 0, 'message', 'content').gsub(/['"「」]/, '')
    save!
  end

  # 比較元の料理の食材の形態素解析結果を配列に格納する(source)
  def source_morphemes_to_array
    ingredients.each do |ingredient|
      @source << ingredient.morphemes.split(',') # sourceには、[["たまご"],["豚","ひき肉"],["なす"]]みたいな感じに格納される
    end
    @source.flatten!
  end

  # DBに保存してある料理(公開済みのもののみ)の食材の形態素解析結果を配列に格納
  def target_morphemes_to_array(dish)
    # ループのたびに初期化する
    @target = []
    dish.ingredients.each do |ingredient|
      @target << ingredient.morphemes.split(',') # targetには、[["にんじん"],["牛","ひき肉"],["とまと"]]みたいな感じに格納される
    end
    @target.flatten!
  end

  # ジャッカード係数を求める
  def calculate_jaccard_index
    # 積集合
    intersection = @source & @target
    # 和集合
    union = @source | @target
    # ジャッカード係数を求める(少数第5位まで)
    @jaccard_index = (intersection.length.to_f / union.length).round(5)
  end

  # 一番大きいジャッカード係数を探して、その料理情報を取得する
  def find_dish_with_highest_jaccard(dish)
    # jaccard_index > highestでない限り、以降の処理を飛ばす
    return unless @jaccard_index > @highest
    # 一番大きいジャッカード係数をhighestに格納
    @highest = @jaccard_index
    # 一番大きいジャッカード係数をもつdishを設定
    @highest_dish = dish
  end
end
