# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can complete packaging step for other project', js: true do
  context 'authenticated user' do
    scenario 'chooses packaging type without technical drawing' do
      product = create(:product, key: 'packaging')
      project = create(:project, state: :draft, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/packaging"

      expect(page).to have_content('Tell us which of the following you would like to design on:')
      expect(page).to have_content('Please select which of the following best describes the type of pack that you would to use:')

      find('#other-packaging-type').click

      expect(page).to have_content('Contact DesignBro')
    end
  end
end
