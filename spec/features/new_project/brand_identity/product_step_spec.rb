# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can create', js: true do
  context 'logo project' do
    context 'product step' do
      scenario 'chooses product' do
        visit '/projects/new'

        expect(page).to have_content('Select project type')

        find('div', text: 'Brand Identity project', exact_text: true).click

        click_on 'Continue'

        expect(page).to have_content 'Let us know what visual style fits your brand'
      end
    end
  end
end
