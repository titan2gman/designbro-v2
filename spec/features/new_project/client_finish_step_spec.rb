# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Checkout Step #2 - Finish', js: true do
  describe 'guest' do
    ['/c', '/c/projects', '/c/projects/new', '/c/projects/new/finish'].each do |url|
      scenario "should be redirected to login page when visit: #{url}" do
        visit url
        expect(page).to have_content('Log in')
      end
    end
  end

  describe 'designer' do
    ['/c', '/c/projects', '/c/projects/new', '/c/projects/new/finish'].each do |url|
      scenario "should be redirected to designer dashboard when visit: #{url}" do
        designer = create(:designer)
        login_as designer.user

        visit url

        expect(page).to have_content('Discover Projects')
      end
    end
  end

  describe 'client' do
    scenario 'should be redirected to the first step (state: waiting_for_details)' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/finish'

      expect(page).to have_content('Continue to Checkout')
      expect(page).to have_current_path('/c/projects/new/details')
    end

    scenario 'should be redirected to the second step (state: waiting_for_checkout)' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

      visit '/c/projects/new/finish'

      expect(page).to have_content('Billing Address')
      expect(page).to have_current_path('/c/projects/new/checkout')
    end

    scenario 'should be redirected to the stationery step (state: waiting_for_stationery_details)' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS, client: client)

      visit '/c/projects/new/finish'

      expect(page).to have_content('Finish')
      expect(page).to have_current_path('/c/projects/new/stationery')
    end
  end
end
