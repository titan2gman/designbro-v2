# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can complete style step for website project', js: true do
  context 'authenticated user' do
    scenario 'chooses audience' do
      product = create(:product, key: 'website')
      project = create(:project, state: :waiting_for_finish_details, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/audience"

      expect(page).to have_content('Tell us about your target audience')

      click_on 'Continue'
      expect(page).to have_content 'Last Questions'
    end

    scenario 'can go back on previous step' do
      product = create(:product, key: 'website')
      project = create(:project, state: :waiting_for_finish_details, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/audience"

      click_button 'Back'
      expect(page).to have_content('Describe your brand DNA')
    end
  end

  context 'not authenticated user' do
    scenario 'chooses audience' do
      product = create(:product, key: 'website')
      project_without_company = create(:project_without_company, state: :waiting_for_finish_details, product: product)

      visit "/projects/#{project_without_company.id}/audience"

      expect(page).to have_content('Tell us about your target audience')

      click_on 'Continue'
      expect(page).to have_content 'Last Questions'
    end
  end
end
