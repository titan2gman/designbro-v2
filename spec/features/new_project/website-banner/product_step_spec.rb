# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can create', js: true do
  context 'website banner project' do
    context 'product step' do
      scenario 'chooses product' do
        visit '/projects/new'

        expect(page).to have_content('Select project type')

        find('div', text: 'Website Banner project', exact_text: true).click

        click_on 'Continue'

        expect(page).to have_content 'Describe your brand DNA'
      end
    end
  end
end
