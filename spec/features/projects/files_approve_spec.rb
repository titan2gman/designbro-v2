# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Approve files', js: true do
  context 'Client can approve designer files' do
    scenario 'Client approves files' do
      designer = create(:designer)
      project = create(:project, state: :review_files, nda: create(:free_nda))
      create(:winner_design, designer: designer, project: project)
      create(:project_source_file, designer: designer, project: project)

      login_as(project.client.user)
      visit "/c/projects/#{project.id}/files"

      find('#approve-files').click
      find('#confirm-and-continue').click

      expect(page).to have_content('How was your Designer?')
    end
  end

  context 'God Client cannot approve designer files' do
    scenario 'God Client approves files' do
      client = create(:god_client)
      designer = create(:designer)
      project = create(:project, state: :review_files, nda: create(:free_nda))
      create(:winner_design, designer: designer, project: project)
      create(:project_source_file, designer: designer, project: project)

      login_as(client.user)
      visit "/c/projects/#{project.id}/files"

      find('#approve-files').click
      find('#confirm-and-continue').click

      visit "/c/projects/#{project.id}/files"

      expect(page).to have_selector('.no-open-modals', visible: false)
      expect(page).to have_content('Approve Files')
    end
  end
end
