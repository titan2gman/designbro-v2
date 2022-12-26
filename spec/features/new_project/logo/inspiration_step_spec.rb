# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can complete inspiration step for logo project', js: true do
  context 'authenticated user' do
    scenario 'chooses examples' do
      product = create(:product, key: 'logo')
      project = create(:project, state: :draft, product: product)
      create_list(:brand_example, 6)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/inspirations"

      expect(page).to have_content('Let us know what visual style fits your brand')

      click_on 'Continue'
      expect(page).to have_content 'Describe your brand DNA'
    end

    scenario 'can not open project that belongs to another company' do
      product = create(:product, key: 'logo')
      project = create(:project, state: :draft, product: product)
      second_project = create(:project, state: :draft, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{second_project.id}/inspirations"

      expect(page).not_to have_content('Let us know what visual style fits your brand')
    end
  end

  context 'not authenticated user' do
    scenario 'chooses examples' do
      product = create(:product, key: 'logo')
      project_without_company = create(:project_without_company, state: :draft, product: product)
      create_list(:brand_example, 6)

      visit "/projects/#{project_without_company.id}/inspirations"

      expect(page).to have_content('Let us know what visual style fits your brand')

      click_on 'Continue'
      expect(page).to have_content 'Describe your brand DNA'
    end
  end

  context 'validation' do
    scenario 'enough brand examples' do
      product = create(:product, key: 'logo')
      project = create(:project, state: :draft, good_examples_count: 0, product: product)
      create_list(:brand_example, 6)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/inspirations"

      3.times { find('i.icon-check').click }
      expect(page).to have_content('You have already selected 3 good examples! Press continue to proceed')
    end

    scenario 'not enough brand examples' do
      product = create(:product, key: 'logo')
      project = create(:project, state: :draft, good_examples_count: 0, product: product)
      create_list(:brand_example, 6)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/inspirations"

      expect(page).to have_content('Let us know what visual style fits your brand')

      find('i.icon-check').click
      click_on 'Continue'
      expect(page).to have_content 'Please select at least 3 logos you like'
    end
  end
end
