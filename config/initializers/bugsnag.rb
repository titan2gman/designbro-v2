# frozen_string_literal: true

Bugsnag.configure do |config|
  config.api_key = ENV.fetch('BUGSNAG_RAILS_API_KEY')
  config.notify_release_stages = ['production', 'staging']
end
