# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'

SimpleCov.start 'rails' do
  add_filter 'app/admin'
end

require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

require 'aasm/rspec'
require 'cancan/matchers'
require 'zonebie/rspec'
require 'webmock/rspec'
require 'wisper/rspec/matchers'
require 'money-rails/test_helpers'
require 'shoulda-matchers'
require 'database_cleaner'
require 'json-schema'
require 'stripe_mock'
require 'rake'

[
  *Dir[Rails.root.join('spec/support/**/*.rb')],
  *Dir[Rails.root.join('spec/concerns/*.rb')],
  *Dir[Rails.root.join('db/migrate/*.rb')]
].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Rails.application.load_tasks

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include FileHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Requests::JsonHelpers, type: :request
  config.include FeatureHelpers, type: :feature
  config.include ActiveJob::TestHelper
  config.include Wisper::RSpec::BroadcastMatcher

  config.before :suite do
    DatabaseCleaner.strategy = :truncation, { except: ['products', 'product_categories'] }

    Rake::Task['products:load'].invoke
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.prepend_before :each do
    FactoryBot.reload
  end

  config.append_after :each do
    DownloadHelpers.clear_downloads
  end

  WebMock.disable_net_connect!(allow_localhost: true)
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
    with.library :action_controller
  end
end
