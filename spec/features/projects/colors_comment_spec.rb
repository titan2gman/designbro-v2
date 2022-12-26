# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Colors comment', js: true do
  scenario 'with colors comment and project colors' do
    project = create(:logo_project, state: Project::STATE_DESIGN_STAGE, colors_comment: 'comment')
    create(:project_color, project: project)

    login_as(project.client.user)
    visit "/c/projects/#{project.id}/brief"

    expect(page).to have_content('Brief')
    expect(page).to have_content(project.colors_comment)
  end

  scenario 'with colors comment and without project colors' do
    project = create(:logo_project, state: Project::STATE_DESIGN_STAGE, colors_comment: 'comment')

    login_as(project.client.user)
    visit "/c/projects/#{project.id}/brief"

    expect(page).to have_content('Brief')
    expect(page).to have_content(project.colors_comment)
  end

  scenario 'without colors comment and with project colors' do
    project = create(:logo_project, state: Project::STATE_DESIGN_STAGE, colors_comment: nil)
    create(:project_color, project: project)

    login_as(project.client.user)
    visit "/c/projects/#{project.id}/brief"

    expect(page).to have_content('Brief')
    expect(page).to have_content('Colors to use')
  end

  scenario 'without colors comment and project colors' do
    project = create(:logo_project, state: Project::STATE_DESIGN_STAGE, colors_comment: nil)

    login_as(project.client.user)
    visit "/c/projects/#{project.id}/brief"

    expect(page).to have_content('Brief')
    expect(page).not_to have_content('Colors to use')
  end
end
