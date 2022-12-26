# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Files downloas', js: true do
  context 'Client can download archive' do
    # doesn't work with headless chrome
    xscenario 'any files present' do
      designer = create(:designer)
      project = create(:project, state: :review_files, nda: create(:free_nda))
      create(:winner_design, designer: designer, project: project)
      create(:project_source_file, designer: designer, project: project)

      login_as(project.client.user)
      visit "/c/projects/#{project.id}/files"

      click_on('Download Zip')

      expect(File.basename(DownloadHelpers.downloaded_file)).to eq("#{project.name}.zip")
    end

    scenario 'no files present' do
      designer = create(:designer)
      project = create(:project, state: :review_files, nda: create(:free_nda))
      create(:winner_design, designer: designer, project: project)

      login_as(project.client.user)
      visit "/c/projects/#{project.id}/files"

      expect(page).not_to have_content('Download Zip')
    end
  end
end
