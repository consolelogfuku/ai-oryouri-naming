module ApplicationHelper
  # ページタイトルの設定
  def page_title(page_title = '')
    base_title = 'AIお料理ネーミング'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  # メタタグの設定
  def default_meta_tags
    {
      site: 'AIお料理ネーミング',
      title: '名もなき料理に名前をつけて遊ぼう',
      description: 'あなたが作った料理にAIが面白い名前をつけるサービスです。',
      keywords: '料理,AI,ChatGPT,料理名,レシピ',
      canonical: request.original_url,

      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja-JP'
      },

      twitter: {
        card: 'summary_large_image',
        site: '',
        image: image_url('ogp.png')
      }
    }
  end
end
