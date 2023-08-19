AIOryouriNaming::Application.config.session_store :redis_store,
  servers: ENV.fetch('UPSTASH_REDIS_URL',ENV['REDIS_URL']), # 本番環境はUPSTASH_REDIS_URLにアクセス
  expire_after: 90.minutes,
  key: ENV['MY_APP_SESSION'],
  threadsafe: true,
  secure: Rails.env.production? # 開発・テスト環境はHTTPSを使用しないため、無効にする