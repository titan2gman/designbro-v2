# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'God Client Dashboard', js: true do
  let(:client) { create(:god_client) }
  let(:product) { create(:product) }
  context 'Tab: In Progress' do
    [
      :design_stage,
      :finalist_stage,
      :files_stage,
      :review_files
    ].each do |state|
      scenario "Have project with state: #{state}" do
        # product = create(:product)
        project = create(:project, state: state, product: product)

        login_as(client.user)
        visit "/c/brands/#{project.brand.id}/in-progress"

        expect(page).to have_content(project.brand.name)
        expect(page).to have_css('.active', text: 'In progress')
        expect(page).to have_content(project.name)
      end
    end

    [
      :completed,
      :error
    ].each do |state|
      scenario "Have no projects with state: #{state}" do
        # product = create(:product)
        project = create(:project, state: state, product: product)

        login_as(client.user)
        visit "/c/brands/#{project.brand.id}/in-progress"

        expect(page).to have_content(project.brand.name)
        expect(page).to have_css('.active', text: 'In progress')
        expect(page).not_to have_content(project.name)
      end
    end
  end

  context 'Tab: Completed' do
    [
      :design_stage,
      :finalist_stage,
      :files_stage,
      :review_files,
      :error
    ].each do |state|
      scenario "Have no projects with state: #{state}" do
        project = create(:project, state: state, product: product)

        login_as(client.user)
        visit "/c/brands/#{project.brand.id}/completed"

        expect(page).to have_content(project.brand.name)
        expect(page).to have_css('.active', text: 'Completed')
        expect(page).not_to have_content(project.name)
      end
    end

    scenario 'Have project with state: completed' do
      product = create(:product)
      project = create(:project, state: :completed, product: product)

      login_as(client.user)
      visit "/c/brands/#{project.brand.id}/completed"

      expect(page).to have_content(project.brand.name)
      expect(page).to have_css('.active', text: 'Completed')
      expect(page).to have_content(project.name)
    end
  end

  scenario 'Can see all brands' do
    projects = create_list(:project, 2)

    login_as(client.user)
    visit '/c'

    projects.each do |project|
      expect(page).to have_content(project.brand.name)
    end
  end

  scenario 'Can choose project status' do
    brand_dna            = create(:brand_dna)
    project              = create(:project, state: :draft, product: product, brand_dna: brand_dna)
    project_completed    = create(:project, state: :completed, product: product, brand_dna: brand_dna)
    project_design_stage = create(:project, state: :design_stage, product: product, brand_dna: brand_dna)

    login_as(client.user)
    visit "/c/brands/#{project.brand.id}/in-progress"

    expect(page).to have_content(project_design_stage.name)

    expect(page).to have_content(project.name)
    expect(page).not_to have_content(project_completed.name)

    visit "/c/brands/#{project.brand.id}/completed"
    expect(page).to have_content(project_completed.name)

    expect(page).not_to have_content(project.name)
    expect(page).not_to have_content(project_design_stage.name)
  end
end
