# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Guest', js: true do
  describe 'can create new project' do
    scenario 'logo' do
      create_list(:brand_example, 6)

      project = create(:logo_project, state: Project::STATE_DRAFT, client: nil)
      set_encrypted_cookie('project_id', project.id)

      visit '/projects/new/examples/logo'

      6.times { find('.icon-check').click }
      expect(page).to have_content('You have already selected 3 good examples! Press continue to proceed')

      click_button 'Continue'
      expect(page).to have_content('Tell us which of the following best fit the image')

      expect(Project.last.project_type).to eq('logo')
    end

    scenario 'brand identity' do
      create_list(:brand_example, 6)

      project = create(:brand_identity_project, state: Project::STATE_DRAFT, client: nil)
      set_encrypted_cookie('project_id', project.id)

      visit '/projects/new/examples/brand-identity'

      6.times { find('.icon-check').click }
      expect(page).to have_content('You have already selected 3 good examples! Press continue to proceed')

      click_button 'Continue'
      expect(page).to have_content('Tell us which of the following best fit the image')

      expect(Project.last.project_type).to eq('brand_identity')
    end
  end

  describe 'can load project brand examples' do
    scenario 'logo' do
      project = create(
        :project,
        client: nil,
        project_type: :logo,
        state: Project::STATE_WAITING_FOR_STYLE_DETAILS
      )
      create_list(:project_brand_example, 6, project: project, example_type: :good)
      create(:project_brand_example, project: project, example_type: :skip)
      create(:project_brand_example, project: project, example_type: :bad)
      set_encrypted_cookie('project_id', project.id)

      visit '/projects/new/style'

      expect(page).to have_content('Tell us which of the following best fit the image')

      click_button 'Back'
      expect(page).to have_content('Let us know what visual style fits your brand')
      expect(page).to have_content('You have already selected 3 good examples! Press continue to proceed')
    end

    scenario 'brand identity' do
      project = create(
        :project,
        client: nil,
        project_type: :brand_identity,
        state: Project::STATE_WAITING_FOR_STYLE_DETAILS
      )
      create_list(:project_brand_example, 6, project: project, example_type: :good)
      create(:project_brand_example, project: project, example_type: :skip)
      create(:project_brand_example, project: project, example_type: :bad)
      set_encrypted_cookie('project_id', project.id)

      visit '/projects/new/style'

      expect(page).to have_content('Tell us which of the following best fit the image')

      click_button 'Back'
      expect(page).to have_content('Let us know what visual style fits your brand')
      expect(page).to have_content('You have already selected 3 good examples! Press continue to proceed')
    end
  end
end
