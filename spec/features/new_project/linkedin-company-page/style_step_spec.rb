# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can complete style step for linkedin company page design project', js: true do
  context 'authenticated user' do
    scenario 'chooses styles' do
      product = create(:product, key: 'linkedin')
      project = create(:project, state: :waiting_for_audience_details, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/style"

      expect(page).to have_content('Describe your brand DNA')

      click_on 'Continue'
      expect(page).to have_content 'Tell us about your target audience'
    end
  end

  context 'not authenticated user' do
    scenario 'chooses styles' do
      product = create(:product, key: 'linkedin')
      project_without_company = create(:project_without_company, state: :waiting_for_audience_details, product: product)

      visit "/projects/#{project_without_company.id}/style"

      expect(page).to have_content('Describe your brand DNA')

      click_on 'Continue'
      expect(page).to have_content 'Tell us about your target audience'
    end
  end
end
