# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer can join a queue', js: true do
  scenario 'Designer joins a queue' do
    designer = create(:designer)
    project  = create(:project, :with_measurements, state: Project::STATE_DESIGN_STAGE)

    create(:designer_nda, nda: project.nda, designer: designer)
    create_list(:reserved_spot, project.max_spots_count, project: project)

    login_as(designer.user)
    visit "/d/projects/#{project.id}"
    expect(page).to have_content('Brand Name')

    find('#reserve-spot').click
    click_on('Join a queue')

    expect(page).to have_selector('.no-open-modals', visible: false)
  end
end
