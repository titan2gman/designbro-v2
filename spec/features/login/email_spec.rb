# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'User can login using his email credentials', js: true do
  describe 'Designer' do
    scenario 'enters valid credentials' do
      credentials = { email: 'example@gmail.com', password: 'pass1234' }
      user = create(:user, credentials)
      create(:designer, user: user)

      visit '/login'
      fill_in :email, with: credentials[:email]
      fill_in :password, with: credentials[:password]
      click_button 'Log in'

      expect(page).to have_selector('.bg-black')
    end

    scenario 'enters invalid credentials' do
      credentials = { email: 'example@gmail.com' }
      user = create(:user, credentials)
      create(:designer, user: user)

      visit '/login'
      fill_in :email, with: credentials[:email]
      fill_in :password, with: 'invalid'
      click_button 'Log in'

      message = I18n.t('devise_token_auth.sessions.bad_credentials')
      expect(page).to have_content(message)
    end
  end

  describe 'Client' do
    scenario 'logins on filling data about project on finish state' do
      client = create(:client)
      user = client.user

      project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
      set_encrypted_cookie('project_id', project.id)

      visit '/projects/new/finish'

      find('.sign-in__form-link').click

      expect(page).to have_css('.modal-primary')

      within('.modal-primary') do
        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_button('Log in')
      end

      expect(page).to have_content('Last Questions')
      expect(page).to have_css('.no-open-modals', visible: false)
      expect(page).not_to have_content('Register to save your progress')
    end

    scenario 'logins after another client' do
      client = create(:client)
      user = client.user

      project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS)
      set_encrypted_cookie('project_id', project.id)

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button('Log in')

      expect(page).to have_content('My Projects')
    end
  end
end
