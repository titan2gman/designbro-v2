# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client', js: true do
  scenario 'Can leave a review for designer' do
    client   = create(:client)
    designer = create(:designer)
    project  = create(:project, state: Project::STATE_COMPLETED, client: client)

    create(:winner_design, designer: designer, project: project)
    create(:project_source_file, designer: designer, project: project)

    login_as(client.user)
    visit "/c/projects/#{project.id}/files"
    expect(page).to have_content(project.name)

    expect(page).to have_selector('.main-modal__info')
    expect(page).not_to have_selector('.no-open-modals')

    within '.design-review' do
      find('#designerComment').set Faker::Lorem.sentence
      all('.icon-star.in-grey-200')[4].click
    end
    within '.overall-review' do
      find('#overallComment').set Faker::Lorem.sentence
      all('.icon-star.in-grey-200')[4].click
    end
    within '.main-modal__info' do
      find('#continue-btn').click
    end

    expect(page).to have_selector('.no-open-modals', visible: false)
    expect(page).not_to have_selector('#review-designer')
  end

  scenario 'Can leave a review for designer in another project' do
    client   = create(:client)
    designer = create(:designer)
    project  = create(:project, state: Project::STATE_COMPLETED, client: client)

    create(:winner_design, designer: designer, project: project)
    create(:project_source_file, designer: designer, project: project)

    review = create(:review, client: client)
    review.design.update(designer: designer)

    login_as(client.user)

    visit "/c/projects/#{project.id}/files"
    expect(page).to have_content(project.name)

    expect(page).to have_selector('.main-modal__info')
    expect(page).not_to have_selector('.no-open-modals')

    within '.design-review' do
      find('#designerComment').set Faker::Lorem.sentence
      all('.icon-star.in-grey-200')[4].click
    end
    within '.overall-review' do
      find('#overallComment').set Faker::Lorem.sentence
      all('.icon-star.in-grey-200')[4].click
    end
    within '.main-modal__info' do
      find('#continue-btn').click
    end

    expect(page).to have_selector('.no-open-modals', visible: false)
    expect(page).not_to have_selector('#review-designer')
  end
end
