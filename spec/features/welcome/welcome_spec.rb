# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Obtain HTML/JS/CSS data', js: true do
  describe 'Client' do
    scenario 'Data about user presents in HTML' do
      client = create(:client)
      user   = client.user

      login_as(user)
      visit '/c'

      expect(page).to have_content('Start a Project')
      expect(page).to have_content('My Projects')
    end
  end

  describe 'Designer' do
    scenario 'Data about user presents in HTML' do
      designer = create(:designer)
      user     = designer.user

      login_as(user)
      visit '/d'

      expect(page).to have_content('My Projects')
      expect(page).to have_content('Discover Projects')
    end
  end
end
