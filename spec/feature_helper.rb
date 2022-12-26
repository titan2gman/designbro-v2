# frozen_string_literal: true

require 'rails_helper'

require 'capybara/email/rspec'
require 'capybara-screenshot/rspec'

Dir[Rails.root.join('spec/features/support/**/*.rb')].each { |f| require f }

Capybara.register_driver :custom_chrome do |app|
  # caps = Selenium::WebDriver::Remote::Capabilities.chrome(
  #   loggingPrefs: {
  #     browser: "ALL",
  #     client: "ALL",
  #     driver: "ALL",
  #     server: "ALL"
  #   }
  # )

  options = Selenium::WebDriver::Chrome::Options.new(
    args: ['headless', 'disable-gpu', 'window-size=1280,1024']
  )

  options.add_preference(:download, prompt_for_download: false, default_directory: DownloadHelpers::PATH)
  options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })

  driver = Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )

  ## Allow file downloads in Google Chrome when headless!!!
  ## https://bugs.chromium.org/p/chromium/issues/detail?id=696481#c89
  # bridge = driver.browser.send(:bridge)

  # path = '/session/:session_id/chromium/send_command'
  # path[':session_id'] = bridge.session_id

  # bridge.http.call(:post,
  #   path,
  #   cmd: 'Page.setDownloadBehavior',
  #   params: {
  #     behavior: 'allow',
  #     downloadPath: DownloadHelpers::PATH
  #   }
  # )

  ## still doesn't work in headless :(

  driver
end

RSpec.configure do |config|
  config.append_before(:all, type: :feature) do
    suppress(STDOUT) do
      ENV['PRECOMPILE_ASSETS'] ||= begin
        require 'rake'
        Rails.application.load_tasks
        Rake::Task['assets:precompile'].invoke
        Time.now.to_s
      end
    end
  end

  # config.after(:each, type: :feature) do
  #   errors = page.driver.browser.manage.logs.get(:browser)
  #   if errors.present?
  #     message = errors.map(&:message).join("\n")
  #     puts message
  #   end
  # end
end

Capybara.configure do |config|
  config.default_selector  = :css
  config.javascript_driver = :custom_chrome
  config.default_max_wait_time = 5
end

# for testing WebSocket
Capybara.server = :puma
Capybara.app_host = 'http://localhost:3001'
Capybara.server_host = 'localhost'
Capybara.server_port = '3001'
Capybara.always_include_port = true

# Keep only the screenshots generated from the last failing test suite
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.register_driver(:custom_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end
