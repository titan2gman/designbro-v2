# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer Dashboard', js: true do
  let(:designer) { create(:designer_with_approved_experience) }

  context 'Tab: In Progress' do
    it 'Project type: DESIGN_STAGE' do
      product = create(:product)
      projects = [:reserved, :design_uploaded, :eliminated].map do |state|
        create(:project, state: :design_stage, product: product).tap do |project|
          create(:spot, project: project, designer: designer, state: state)
        end
      end

      login_as(designer.user)
      visit '/d/in-progress'

      expect(page).to have_content('In Progress')
      expect(page).to have_content(projects.first.name)
      expect(page).to have_content(projects.second.name)

      expect(page).not_to have_content(projects.third.name)
    end

    it 'Project type: FINALIST_STAGE' do
      product = create(:product)
      projects = [:stationery, :stationery_uploaded, :finalist, :eliminated].map do |state|
        create(:project, state: :finalist_stage, product: product).tap do |project|
          create(:spot, project: project, designer: designer, state: state)
        end
      end

      login_as(designer.user)
      visit '/d/in-progress'

      expect(page).to have_content('In Progress')
      expect(page).to have_content(projects.first.name)
      expect(page).to have_content(projects.second.name)
      expect(page).to have_content(projects.third.name)

      expect(page).not_to have_content(projects.last.name)
    end

    it 'Project type: FILES_STAGE' do
      product = create(:product)
      projects = [:winner, :eliminated].map do |state|
        create(:project, state: :files_stage, product: product).tap do |project|
          create(:spot, project: project, designer: designer, state: state)
        end
      end

      login_as(designer.user)
      visit '/d/in-progress'

      expect(page).to have_content('In Progress')
      expect(page).to have_content(projects.first.name)

      expect(page).not_to have_content(projects.last.name)
    end

    it 'Project type: REVIEW_FILES' do
      product = create(:product)
      projects = [:winner, :eliminated].map do |state|
        create(:project, state: :review_files, product: product).tap do |project|
          create(:spot, project: project, designer: designer, state: state)
        end
      end

      login_as(designer.user)
      visit '/d/in-progress'

      expect(page).to have_content('In Progress')
      expect(page).to have_content(projects.first.name)

      expect(page).not_to have_content(projects.last.name)
    end
  end

  context 'Tab: Completed' do
    [:design_stage, :finalist_stage, :files_stage, :review_files].each do |state|
      scenario "Have no projects with state: #{state}" do
        product = create(:product)
        project = create(:project, state: state, product: product)

        create(:spot, project: project, designer: designer)

        login_as(designer.user)
        visit '/d/completed'

        expect(page).to have_content('Completed')
        expect(page).not_to have_content(project.name)
      end
    end

    scenario 'Have project with state: completed' do
      product = create(:product)
      project = create(:project, state: :completed, product: product)

      create(:spot, project: project, designer: designer)

      login_as(designer.user)
      visit '/d/completed'

      expect(page).to have_content('Completed')
      expect(page).to have_content(project.name)
    end

    scenario 'Have project with state: error' do
      product = create(:product)
      project = create(:project, state: :error, product: product)

      create(:spot, project: project, designer: designer)

      login_as(designer.user)
      visit '/d/completed'

      expect(page).to have_content('Completed')
      expect(page).not_to have_content(project.name)
    end
  end

  context 'Tab: Discover' do
    scenario 'Can choose All tab' do
      logo_product           = create(:logo_product)
      packaging_product      = create(:packaging_product)
      brand_identity_product = create(:product, key: 'brand-identity')
      logo_project           = create(:project, state: :design_stage, product: logo_product)
      packaging_project      = create(:project, state: :design_stage, product: packaging_product)
      brand_identity_project = create(:project, state: :design_stage, product: brand_identity_product)

      login_as(designer.user)
      visit('/d/discover/')

      expect(page).to have_content(brand_identity_project.name)

      expect(page).to have_content(packaging_project.name)
      expect(page).to have_content(logo_project.name)
    end

    scenario 'Can choose packaging tab' do
      logo_product           = create(:logo_product)
      packaging_product      = create(:packaging_product)
      brand_identity_product = create(:product, key: 'brand-identity')
      logo_project           = create(:project, state: :design_stage, product: logo_product)
      packaging_project      = create(:project, state: :design_stage, product: packaging_product)
      brand_identity_project = create(:project, state: :design_stage, product: brand_identity_product)

      login_as(designer.user)
      visit("/d/discover/#{packaging_product.product_category_id}")

      expect(page).to have_content(packaging_project.name)

      expect(page).not_to have_content(logo_project.name)
      expect(page).not_to have_content(brand_identity_project.name)
    end

    scenario 'Can choose brand identity tab' do
      logo_product           = create(:logo_product)
      packaging_product      = create(:packaging_product)
      brand_identity_product = create(:product, key: 'brand-identity')
      logo_project           = create(:project, state: :design_stage, product: logo_product)
      packaging_project      = create(:project, state: :design_stage, product: packaging_product)
      brand_identity_project = create(:project, state: :design_stage, product: brand_identity_product)

      login_as(designer.user)
      visit("/d/discover/#{brand_identity_product.product_category_id}")

      expect(page).to have_content(brand_identity_project.name)
      expect(page).to have_content(logo_project.name)

      expect(page).not_to have_content(packaging_project.name)
    end
  end

  context 'Can filter projects' do
    scenario 'with free spots' do
      product             = create(:product)
      completed_project   = create(:project, state: :completed, product: product)
      free_spots_project  = create(:project, state: :design_stage, product: product)
      taken_spots_project = create(:project, state: :design_stage, product: product)
      project_with_one_reserved_spot = create(:project, state: :design_stage, product: product)

      create_list(:reserved_spot, 3, project: taken_spots_project, designer: designer)
      create(:reserved_spot, project: project_with_one_reserved_spot, designer: designer)

      login_as(designer.user)
      visit '/d/discover'

      expect(page).to have_content(free_spots_project.name)
      expect(page).to have_content(taken_spots_project.name)
      expect(page).to have_content(project_with_one_reserved_spot.name)
      expect(page).not_to have_content(completed_project.name)

      dropdown_select 'With free spots', from: '#state-filter'
      expect(page).to have_selector('.spinner')

      expect(page).to have_content(free_spots_project.name)
      expect(page).to have_content(project_with_one_reserved_spot.name)
      expect(page).not_to have_content(completed_project.name)
      expect(page).not_to have_content(taken_spots_project.name)
    end

    scenario 'with taken spots' do
      product             = create(:product)
      free_spots_project  = create(:project, state: :design_stage, product: product)
      taken_spots_project = create(:project, state: :design_stage, product: product)
      project_with_one_reserved_spot = create(:project, state: :design_stage, product: product)

      create_list(:reserved_spot, 3, project: taken_spots_project, designer: designer)
      create(:reserved_spot, project: project_with_one_reserved_spot, designer: designer)

      login_as(designer.user)
      visit('/d/discover')

      expect(page).to have_content(free_spots_project.name)
      expect(page).to have_content(taken_spots_project.name)
      expect(page).to have_content(project_with_one_reserved_spot.name)

      dropdown_select 'Without free spots', from: '#state-filter'
      expect(page).to have_selector('.spinner')

      expect(page).to have_content(taken_spots_project.name)
      expect(page).not_to have_content(project_with_one_reserved_spot.name)
      expect(page).not_to have_content(free_spots_project.name)
    end
  end

  scenario 'Can search projects by name' do
    product  = create(:product)
    project1 = create(:project, name: 'abc', state: :design_stage, product: product)
    project2 = create(:project, name: 'def', state: :design_stage, product: product)

    login_as(designer.user)
    visit('/d/discover')

    expect(page).to have_content(project1.name)
    expect(page).to have_content(project2.name)

    find('#search').set(project1.name)
    find('#search').native.send_keys(:return)
    expect(page).to have_selector('.spinner')

    expect(page).to have_content(project1.name)
    expect(page).not_to have_content(project2.name)
  end

  scenario 'Have full manage panel' do
    product                = create(:product)
    logo_product           = create(:logo_product)
    packaging_product      = create(:packaging_product)
    brand_identity_product = create(:product, key: 'brand-identity')
    logo_project           = create(:project, state: :design_stage, product: logo_product)
    packaging_project      = create(:project, state: :design_stage, product: packaging_product)
    brand_identity_project = create(:project, state: :design_stage, product: brand_identity_product)

    [logo_project, brand_identity_project, packaging_project].each do |project|
      create(:design, project: project, designer: designer)
    end

    completed_project = create(:project, state: :completed, product: product)

    create(:finalist_design, project: completed_project, designer: designer)
    create(:winner_design, project: completed_project, designer: designer)

    login_as(designer.user)
    visit '/d/discover'

    within('.manage-panel__section--stats') do
      expect(page).to have_content('3')
      expect(page).to have_content('1', count: 2)
    end
  end

  scenario 'Can see NDA by clicking on "See Project"' do
    product = create(:product)
    project = create(:project, state: :design_stage, product: product)
    create(:custom_nda, brand: project.brand)

    login_as(designer.user)
    visit '/d/discover'

    expect(page).to have_content(project.name)

    find('.main-button', text: 'See Project').click

    expect(page).to have_content('Non-Disclosure Agreement')
  end

  scenario 'Can see NDA by clicking on banner' do
    product = create(:product)
    project = create(:project, state: :design_stage, product: product)
    create(:custom_nda, brand: project.brand)

    login_as(designer.user)
    visit '/d/discover'

    expect(page).to have_content(project.name)

    js_click('.project-card')

    expect(page).to have_content('Non-Disclosure Agreement')
  end
end
