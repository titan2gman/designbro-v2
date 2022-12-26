# frozen_string_literal: true

module FeatureHelpers
  def login_as(user)
    set_cookies(user.create_new_auth_token)
    set_encrypted_cookie('signed_uid', user.uid)
  end

  def logout
    Capybara.current_session.driver.clear_cookies
  end

  def set_cookies(hash)
    hash.each { |key, value| set_cookie(key, value) }
  end

  def set_cookie(key, value)
    if Capybara.current_session.driver.browser.instance_of? Selenium::WebDriver::Chrome::Driver
      # Selenium Chrome driver (JS)
      visit '/some-root-path'
      page.driver.browser.manage.add_cookie(name: key, value: value)
    else
      # Rack::Test driver (non-JS)
      headers = {}
      Rack::Utils.set_cookie_header!(headers, key, value)

      cookie_string = headers['Set-Cookie']
      Capybara.current_session.driver.browser.set_cookie cookie_string
    end
  end

  def set_encrypted_cookie(key, value)
    secret_key = Rails.application.secrets.secret_key_base
    key_generator = ActiveSupport::KeyGenerator.new(secret_key, iterations: 1000)

    secret = key_generator.generate_key('encrypted cookie', 32)
    sign_secret = key_generator.generate_key('signed encrypted cookie')
    options = { serializer: ActiveSupport::MessageEncryptor::NullSerializer, cipher: 'aes-256-cbc' }
    encryptor = ActiveSupport::MessageEncryptor.new(secret, sign_secret, options)

    set_cookie(key, encryptor.encrypt_and_sign(value.to_json))
  end

  def dropdown_select(what, from:)
    find(from).click
    find('.item', text: what, exact_text: true).click
  end

  def js_click(selector)
    expect(page).to have_selector(selector)
    execute_script "document.querySelector('#{selector}').click()"
  end
end
