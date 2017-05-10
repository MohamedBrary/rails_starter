source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# latest ruby version
ruby '2.4.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'

# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'debbie'

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
  gem 'vcr'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'faker'
  gem 'rspec_api_documentation'

  # Use mysql as the database for Active Record
  gem 'mysql2', '>= 0.3.18', '< 0.5'
end

group :test do
  gem 'webmock'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # used to populate database with fake data  
  gem 'populator'  
  gem 'colorize' # Coloring the console output
end

group :production do
  # For deploying to Heroku
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# HAML and Bootstrap
gem 'haml-rails'
gem 'bootstrap-generators'
gem 'devise-bootstrap-views'
gem 'simple_form'

# User authentication
gem 'devise', github: 'plataformatec/devise'
gem 'erubis'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'google-api-client', require: 'google/apis'

# User authorization
gem 'pundit'

# Store cookies as activerecord, TODO special commit compaitable with Rails 5.1
gem 'activerecord-session_store', :git => 'https://github.com/rails/activerecord-session_store.git', :ref => '3fc715a434e2b58c07ef91b34b9e2a39c4d47a37'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# API documentation gem
gem 'apitome'