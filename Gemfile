source "https://rubygems.org"

ruby "3.1.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8.1"

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5.6"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Autenticação App
gem "bcrypt", "~> 3.1.7"
gem 'jwt', '~> 2.7', '>= 2.7.1'

gem 'rqrcode'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"


# gems
gem 'devise'
gem 'devise_token_auth'
# gem 'omniauth'
# gem 'omniauth-google-oauth2'
# gem "omniauth-rails_csrf_protection", "~> 1.0"

gem 'letter_opener'

# documentação de rotas
gem 'rswag-api'
gem 'rswag-ui'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'rswag-specs'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

