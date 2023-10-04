source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
gem 'sassc-rails'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# UI/UX
gem 'enum_help'
gem 'rails-i18n'

# 環境変数管理
gem 'dotenv-rails'

# 定数管理
gem 'config'

# OpenAI
gem 'ruby-openai'

# ログイン
gem 'sorcery'

# ページネーション
gem 'kaminari'

# 画像アップロード
gem 'carrierwave', '~> 3.0'

# 画像編集
gem "mini_magick"

# AWS接続用
gem 'fog-aws'

# SEO対策
gem "meta-tags"

# Redis
gem "redis", "~> 4.8.1", "< 5" # redis4系でないとactionpackが動かない
gem 'redis-actionpack'

# 形態素解析
gem 'tiny_segmenter'

# 翻訳
gem 'deepl-rb', require: 'deepl'

# 利用規約・プライバシーポリシーに使用
gem 'high_voltage', '~> 3.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'letter_opener_web', '~> 2.0'
  gem 'pry-rails'

  # Lint、コード解析
  gem 'bullet'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false

  # テスト
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'
  gem 'webdrivers'
  gem 'capybara'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # debug
  gem 'better_errors'
  gem 'binding_of_caller'

  # solargraph
  gem 'solargraph'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
