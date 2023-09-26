AIOryouriNaming::Application.config.session_store :redis_store,
                                                  servers: ENV.fetch('UPSTASH_REDIS_URL', ENV.fetch('REDIS_URL', nil)), # 本番環境はUPSTASH_REDIS_URLにアクセス
                                                  expire_after: 90.minutes,
                                                  key: ENV.fetch('MY_APP_SESSION', nil),
                                                  threadsafe: true,
                                                  secure: Rails.env.production? # 開発環境はHTTSだが、テスト環はHTTPSを使用しないため、無効にする
