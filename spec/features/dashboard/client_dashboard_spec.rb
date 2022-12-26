# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client Dashboard', js: true do
  let(:product) { create(:product) }
  context 'Tab: In Progress' do
    [
      :design_stage,
      :finalist_stage,
      :files_stage,
      :review_files
    ].each do |state|
      scenario "Have project with state: #{state}" do
        project = create(:project, state: state, product: product)

        login_as(project.brand.company.clients.first.user)
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
        project = create(:project, state: state, product: product)

        login_as(project.brand.company.clients.first.user)
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

        login_as(project.brand.company.clients.first.user)
        visit "/c/brands/#{project.brand.id}/completed"

        expect(page).to have_content(project.brand.name)
        expect(page).to have_css('.active', text: 'Completed')
        expect(page).not_to have_content(project.name)
      end
    end

    scenario 'Have project with state: completed' do
      project = create(:project, state: :completed, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/c/brands/#{project.brand.id}/completed"

      expect(page).to have_content(project.brand.name)
      expect(page).to have_css('.active', text: 'Completed')
      expect(page).to have_content(project.name)
    end
  end

  scenario 'Can see his brands list' do
    product = create(:product)
    project = create(:project, state: :design_stage, product: product)
    brands = create_list(:brand, 2, company: project.brand.company)

    login_as(project.brand.company.clients.first.user)
    visit '/c'
    expect(page).to have_content('My Brands')

    brands.map(&:name).each do |name|
      expect(page).to have_content(name)
    end
  end

  scenario 'Can choose project status' do
    brand_dna            = create(:brand_dna)
    project              = create(:project, state: :draft, product: product, brand_dna: brand_dna)
    project_completed    = create(:project, state: :completed, product: product, brand_dna: brand_dna)
    project_design_stage = create(:project, state: :design_stage, product: product, brand_dna: brand_dna)

    login_as(project.brand.company.clients.first.user)
    visit "/c/brands/#{project.brand.id}/in-progress"

    expect(page).to have_content(project_design_stage.name)
    expect(page).to have_content(project.name)
    expect(page).not_to have_content(project_completed.name)

    visit "/c/brands/#{project.brand.id}/completed"
    expect(page).to have_content(project_completed.name)

    expect(page).not_to have_content(project.name)
    expect(page).not_to have_content(project_design_stage.name)
  end

  scenario 'Can open projects list by clicking on Brand' do
    brand_dna = create(:brand_dna)
    project   = create(:project, state: :design_stage, product: product, brand_dna: brand_dna)

    login_as(project.brand.company.clients.first.user)
    visit '/c'
    expect(page).to have_content('My Brands')

    find('div.brand-item', text: project.brand.name).click

    expect(page).to have_content(project.brand.name)
    expect(page).to have_content(project.name)
  end

  scenario 'Can open project by clicking on banner' do
    project = create(:project, state: :design_stage, product: product)

    login_as(project.brand.company.clients.first.user)
    visit "/c/brands/#{project.brand.id}/in-progress"

    expect(page).to have_content(project.name)

    js_click('.project-card')

    expect(page).to have_content(project.brand.name)
    expect(page).to have_content('Brief')
  end
end
