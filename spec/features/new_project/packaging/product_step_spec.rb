# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can create', js: true do
  context 'logo project' do
    context 'product step' do
      scenario 'chooses product' do
        visit '/projects/new'

        expect(page).to have_content('Select project type')

        find('div', text: 'Packaging project', exact_text: true).click

        click_on 'Continue'

        expect(page).to have_content 'Tell us which of the following you would like to design on:'
      end
    end
  end
end
