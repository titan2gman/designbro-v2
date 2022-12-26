# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Сan switch to previously uploaded design', js: true do
  scenario 'Designer can restore' do
    designer = create(:designer)
    project  = create(:project, state: Project::STATE_DESIGN_STAGE)
    design   = create(:design, project: project, designer: designer)

    create(:designer_nda, nda: project.nda, designer: designer)

    old_image = design.uploaded_file.file_url
    design.update(uploaded_file: create(:design_file))

    login_as(designer.user)
    visit "/d/projects/#{project.id}/designs/#{design.id}"

    find('#restore-previous-versions-btn').click

    expect(page).to have_selector('.preview-viewer-list__item', count: 2)
    expect(page).to have_selector('.preview-viewer-list__item--active', count: 1)
    find('.preview-viewer-list__item:nth-child(2)').click
    find('#restore-version-btn').click
    expect(page).to have_text('Your design was successfully updated!')
    js_click '#simple-modal-close'
    expect(find('#current-design-img')[:src]).to match(old_image)
  end

  scenario "Client can't restore" do
    client   = create(:client)
    designer = create(:designer)
    project  = create(:project, state: Project::STATE_DESIGN_STAGE, client: client)
    design   = create(:design, project: project, designer: designer)

    create(:designer_nda, nda: project.nda, designer: designer)
    design.update(uploaded_file: create(:design_file))

    login_as(client.user)
    visit "/c/projects/#{project.id}/designs/#{design.id}"

    js_click('#restore-previous-versions-btn')

    expect(page).to have_selector('.preview-viewer-list__item', count: 2)
    expect(page).to have_selector('.preview-viewer-list__item--active', count: 1)

    find('.preview-viewer-list__item:nth-child(2)').click

    expect(page).not_to have_selector('#restore-version-btn')
  end
end
