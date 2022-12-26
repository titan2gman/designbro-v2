# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'sprockets/railtie'
require 'active_job/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'active_model/railtie'
require 'action_mailer/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Designbro
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.active_record.schema_format = :sql

    config.active_job.queue_adapter = :sidekiq
    config.action_cable.mount_path = '/cable'

    Stripe.api_key = ENV.fetch('STRIPE_SECRET_KEY') unless Rails.env.test?
  end
end

Rails.application.routes.default_url_options = { host: ENV['MAILER_HOST'] }
