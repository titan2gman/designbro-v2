# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer block', js: true do
  context 'Client can block designer' do
    scenario 'with uploaded design' do
      project = create(:project, state: Project::STATE_DESIGN_STAGE)
      create(:design, project: project)

      login_as(project.client.user)
      visit "/c/projects/#{project.id}"

      expect(page).to have_content(project.name)

      first('.preview-frame-menu').click
      all('span', text: 'Block Designer').last.click
      expect(page).to have_selector('#block-designer-modal')

      find('#modal-confirm').click
      expect(page).to have_selector('.no-open-modals', visible: false)

      expect(page).to have_content('0/3Spots')
      expect(page).to have_content('0/3Designs')
    end
  end

  context 'God Client cannot block designer' do
    scenario 'with uploaded design' do
      client = create(:god_client)
      project = create(:project, state: Project::STATE_DESIGN_STAGE)
      create(:design, project: project)

      login_as(client.user)
      visit "/c/projects/#{project.id}"

      expect(page).to have_content(project.name)

      first('.preview-frame-menu').click
      all('span', text: 'Block Designer').last.click
      expect(page).to have_selector('#block-designer-modal')

      find('#modal-confirm').click
      expect(page).to have_selector('.no-open-modals', visible: false)

      expect(page).to have_content('1/3Spots')
      expect(page).to have_content('1/3Designs')
    end
  end
end
