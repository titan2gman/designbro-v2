# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer can reserve spot', js: true do
  scenario 'Designer reserves spot' do
    user    = create(:designer).user
    project = create(:project, :with_measurements, state: Project::STATE_DESIGN_STAGE)

    create(:designer_nda, nda: project.nda, designer: user.designer)

    login_as(user)
    visit "/d/projects/#{project.id}"
    expect(page).to have_content('Brand Name')

    find('#reserve-spot').click
    click_on('Reserve your spot')

    expect(page).to have_selector('.no-open-modals', visible: false)
    expect(page).to have_content('1/3')
  end

  scenario 'Designer reserves second spot' do
    designer = create(:designer)
    project  = create(:project, state: Project::STATE_DESIGN_STAGE, nda: nil)

    create(:design, project: project, designer: designer)
    create(:designer_nda, nda: project.nda, designer: designer)

    login_as(designer.user)
    visit "/d/projects/#{project.id}/designs"
    expect(page).to have_content(designer.display_name)

    find('#reserve-spot').click
    click_on('Reserve your spot')

    expect(page).to have_selector('.no-open-modals', visible: false)
    expect(page).to have_content('2/3')
  end
end
