# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can complete finish step for logo project', js: true do
  context 'authenticated user' do
    scenario 'chooses brand finish details' do
      product = create(:product, key: 'logo')
      project = create(:project, state: :waiting_for_finish_details, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/finish"

      expect(page).to have_content 'Last Questions'
      # expect(page).not_to have_content('Create your account')

      # within 'main.sign-in__container' do
      #   find('span.sign-in__form-link').click
      # end
      #
      # expect(page).to have_content('Log in now to save your work!')
      #
      # within 'div.modal-primary' do
      #   fill_in :email, with: project.brand.company.clients.first.user.email
      #   fill_in :password, with: 'secret123'
      #
      #   find('button.sign-in__form-action').click
      # end
      #
      # expect(page).to have_selector('.no-open-modals', visible: false)
      # expect(page).not_to have_content('Create your account')

      find('input[name=brandName]').set 'Brand Name'
      find('textarea[name=description]').set 'description'
      # [:slogan, :additional_text, :description, :ideas_or_special_requirements].each do |field|
      #   fill_in field, with: field.to_s
      # end

      click_on 'Continue'
      expect(page).to have_content 'Boost your project'
    end

    scenario 'can go back on previous step' do
      product = create(:product, key: 'logo')
      project = create(:project, state: :waiting_for_finish_details, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/finish"

      click_button 'Back'
      expect(page).to have_content('Tell us about your target audience')
    end
  end

  context 'not authenticated user' do
    scenario 'client can sign up' do
      product = create(:product, key: 'logo')
      client = create(:client)
      project_without_company = create(:project_without_company, state: :waiting_for_finish_details, product: product)

      visit "/projects/#{project_without_company.id}/finish"

      expect(page).to have_content('Last Questions')
      expect(page).to have_content('Create your account')

      fill_in :email, with: client.email
      fill_in :password, with: 'password123'

      # fill_in :brand_name, with: 'Brand'

      # [:slogan, :brand_name, :additional_text, :company_description, :ideas_or_special_requirements].each do |field|
      #   fill_in field, with: field.to_s
      # end

      click_on 'Continue'
      expect(page).to have_content 'Last Questions'
    end
  end
end
