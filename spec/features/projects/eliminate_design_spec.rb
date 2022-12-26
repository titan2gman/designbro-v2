# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Eliminate design', js: true do
  context 'Client can eliminate design' do
    scenario 'with uploaded design' do
      project = create(:project, state: Project::STATE_DESIGN_STAGE)
      create(:design, project: project)

      login_as(project.client.user)
      visit "/c/projects/#{project.id}"

      expect(page).to have_content(project.name)

      first('.preview-frame-menu').click
      all('span', text: 'Eliminate Work').last.click
      expect(page).to have_selector('#eliminate-work-modal')

      find('#modal-confirm').click
      expect(page).to have_selector('.no-open-modals', visible: false)

      expect(page).to have_content('0/3Spots')
      expect(page).to have_content('0/3Designs')
    end
  end
end
