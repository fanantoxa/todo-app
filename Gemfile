source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails', '4.2.5'
gem 'pg', '~> 0.15'
gem 'rails_12factor', group: :production
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'acts_as_list'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'sprockets', '2.12.3'

gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'angularjs-rails'
gem 'angular-rails-templates'
gem 'angular-ui-router-rails'

source "https://rails-assets.org" do
  gem "rails-assets-angular-devise"
end

# Protection
gem 'angular_rails_csrf'

# Authentication
gem 'devise'
gem 'omniauth-facebook'
gem 'puma'

group :development, :test do
  gem 'thin', '~> 1.6.4'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'jasmine-rails'
  gem 'spring'
end

group :development do
  gem 'better_errors'
end

group :test do
  gem 'capybara-rails'
  gem 'site_prism', '~> 2.8'
  gem 'database_cleaner', '~> 1.5.1'
  gem 'shoulda-matchers', '~>3.0.1'
  gem 'selenium-webdriver', '~> 2.48.1'
  gem 'factory_girl_rails'
  gem 'faker'
end

