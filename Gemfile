source 'https://rubygems.org'

branch = ENV.fetch("SPREE_BRANCH", "2-4-stable")
gem 'spree', github: 'spree/spree', branch: branch

# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: branch

# Asset compilation speed
gem 'mini_racer'
gem 'sassc-rails', platforms: :mri

group :development, :test do
  gem 'listen'
  gem "pry-rails"
  gem 'selenium-webdriver', require: false
  gem 'chromedriver-helper', require: false
  gem 'ffaker'

  gem 'pg'
  gem 'mysql2', '~> 0.3.13'
end

gemspec
