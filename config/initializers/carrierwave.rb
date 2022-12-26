# frozen_string_literal: true

if Rails.env.production? || Rails.env.staging?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
      aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      region: ENV.fetch('S3_REGION'),
      path_style: true
    }

    config.storage = :fog
    config.fog_public = false
    config.fog_authenticated_url_expiration = 2.hours

    config.fog_directory  = ENV.fetch('S3_PRODUCTION_BUCKET_NAME') if Rails.env.production?
    config.fog_directory  = ENV.fetch('S3_STAGING_BUCKET_NAME')    if Rails.env.staging?
  end
end
