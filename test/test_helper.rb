ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'database_cleaner'
DatabaseCleaner.clean_with :truncation

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
end
