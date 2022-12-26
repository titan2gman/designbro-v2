# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'User can close chat', js: true do
  scenario 'Designer closes chat' do
    designer = create(:designer)
    project  = create(:project, state: Project::STATE_DESIGN_STAGE)
    design   = create(:design, project: project, designer: designer)

    create(:designer_nda, designer: designer, nda: project.nda)

    login_as(designer.user)
    visit "/d/projects/#{project.id}/designs/#{design.id}"

    expect(page).to have_selector('.fullscreen-box__aside.conv-content-aside')
    find('#close-direct-conversation-chat').click

    expect(page).not_to have_selector('.fullscreen-box__aside.conv-content-aside')
  end
end
