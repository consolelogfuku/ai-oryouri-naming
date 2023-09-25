AIOryouriNaming::Application.config.session_store :redis_store,
                                                  servers: ENV.fetch('UPSTASH_REDIS_URL', ENV.fetch('REDIS_URL', nil)), # 本番環境はUPSTASH_REDIS_URLにアクセス
                                                  expire_after: 90.minutes,
                                                  key: ENV.fetch('MY_APP_SESSION', nil),
                                                  threadsafe: true,
                                                  secure: true # 開発環境でもHTTPSを使用しているため、trueとする
                                                  # 参考(https://github.com/redis-store/redis-rails#session-storage)