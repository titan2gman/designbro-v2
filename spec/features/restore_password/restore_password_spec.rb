# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'User can restore password using his email credentials', js: true do
  describe 'Designer restore password' do
    scenario 'Designer enters valid credentials' do
      user = create(:designer).user

      visit '/restore-password'
      fill_in :email, with: user.email
      click_on 'Restore'
      expect(page).to have_content 'Success!'
      open_email(user.email)
      current_email.click_link 'Change my password'
      fill_in :password, with: 'pass12345'
      click_on 'Set Password'
      expect(page).to have_selector('#simple-modal')
      js_click '#simple-modal-close'
      fill_in :email, with: user.email
      fill_in :password, with: 'pass12345'
      click_button 'Log in'

      expect(page).to have_selector('.bg-black')
    end

    scenario 'Designer enters invalid credentials' do
      visit '/restore-password'
      fill_in :email, with: 'invalid@gmail.com'
      click_on 'Restore'

      message = "Unable to find user with email 'invalid@gmail.com'."
      expect(page).to have_content message
    end
  end
end
