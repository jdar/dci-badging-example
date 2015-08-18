source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'

gem 'google-webfonts-rails'

# Use postgresql as the database for Active Record
gem 'pg'

# To extract sensitive configuration
gem 'app_configuration'

# Use unicorn as the app server
gem 'unicorn'

group :assets do
  # Use SCSS for stylesheets
  gem 'sass-rails',   '~> 4.0.0'

  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'

  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.0.3'
end

gem "less-rails"
gem "therubyracer"
gem 'twitter-bootstrap-rails', '~> 2.2.8'#, :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git', :ref => "ca703a2"

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'loadjs'

gem 'inherited_resources' #<-- todo: deprecated
gem 'acts-as-taggable-on', '~> 3.4'

gem 'carrierwave'

gem 'turbolinks'

gem 'jquery-turbolinks'

gem 'devise'

#CodeClimate Reporter
gem "codeclimate-test-reporter", group: :test, require: nil
gem 'simplecov', :require => false, :group => :test

# Active Admin
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'formtastic', github: 'justinfrench/formtastic'

# Enables HAML templates
gem "haml-rails"

# Resque, Resque Mailer and Scheduler
=begin
gem 'resque'
gem 'resque_mailer'
gem "resque-batched-job"
gem 'rufus-scheduler', '~> 2.0.24'
gem 'resque-scheduler', '~> 2.5.5', :require => 'resque_scheduler'
=end

gem 'pundit'

gem 'surrounded'

gem "slim-rails"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rubocop'
end

group :debugging, :development, :test do
  gem 'byebug'
end

group :test, :development do
  gem 'faker'
  gem 'cucumber-rails', :require => false
  gem 'rspec' #only for the 'expect()' syntax.
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
  gem 'headless'

  gem 'database_cleaner', github: 'bmabey/database_cleaner'

  # Modify time in tests
  gem 'timecop'

  # Cucumber with JS
  gem 'poltergeist'

  # Save and open page cucumber
  gem 'launchy'
end

group :production, :staging do
  gem 'rails_12factor'
end
