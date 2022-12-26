# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Finalists selection', js: true do
  context 'Client can select' do
    scenario 'one finalist' do
      project = create(:project, state: Project::STATE_DESIGN_STAGE)

      create_list(:design, 3, project: project)

      login_as(project.client.user)
      visit "/c/projects/#{project.id}"
      expect(page).to have_content(project.name)

      first('.preview-frame-menu').click
      first('span', text: 'Select Finalist (3 left)').click
      expect(page).to have_selector('#finalist-modal')

      find('#modal-confirm').click
      expect(page).to have_selector('.no-open-modals', visible: false)
      expect(page).to have_content('Finalists (1/3)')
    end

    scenario 'three finalists' do
      project = create(:project, state: Project::STATE_DESIGN_STAGE)
      designs = create_list(:design, 3, project: project)

      login_as(project.client.user)
      visit "/c/projects/#{project.id}"
      expect(page).to have_content(project.name)

      designs.each do |design|
        within "#design-#{design.spot.id}" do
          find('.preview-frame-menu').click
          find('.select-finalist-btn').click
        end

        click_button('Confirm')
      end

      expect(page).to have_selector('.no-open-modals', visible: false)
      expect(page).to have_content('Finalists (3/3)')
    end
  end

  context 'God Client cannot select' do
    let(:client) { create(:god_client) }

    scenario 'finalist' do
      project = create(:project, state: Project::STATE_DESIGN_STAGE)

      create_list(:design, 3, project: project)

      login_as(client.user)
      visit "/c/projects/#{project.id}"
      expect(page).to have_content(project.name)

      first('.preview-frame-menu').click
      first('span', text: 'Select Finalist (3 left)').click
      expect(page).to have_selector('#finalist-modal')

      find('#modal-confirm').click
      expect(page).to have_selector('.no-open-modals', visible: false)
      expect(page).not_to have_content('Finalists (1/3)')
    end
  end
end
