# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Ability to create packaging project', js: true do
  describe 'client' do
    pending 'can contact support' do
      login_as create(:client).user

      visit '/projects/new/packaging-type'
      find('#other-packaging-type').click

      click_on 'Contact DesignBro'

      expect(page).to have_content 'Send Message'
    end
  end

  describe 'designer' do
    it 'should be redirected to dashboard' do
      login_as create(:designer).user
      visit '/projects/new/packaging-type'

      expect(page).not_to have_content 'Tell us which of the following'
    end
  end
end
