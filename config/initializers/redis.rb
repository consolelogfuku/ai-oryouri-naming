require 'redis'

# gem 'redis'により、Redisクラスが使えるようになる
REDIS = Redis.new(url: ENV.fetch('UPSTASH_REDIS_URL', ENV.fetch('REDIS_URL', nil)))
