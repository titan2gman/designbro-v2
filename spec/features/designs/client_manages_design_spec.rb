# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client', js: true do
  scenario 'can update rating of the design' do
    client  = create(:client)
    project = create(:project, client: client, state: Project::STATE_DESIGN_STAGE)
    design  = create(:design, project: project, rating: 1)

    login_as(client.user)
    visit "/c/projects/#{project.id}/designs/#{design.id}"

    within '.rating-stars' do
      find('i.icon-star:nth-child(3)').click

      expect(page).to have_selector('.icon-star.in-pink-500', count: 3)
    end
  end

  scenario 'can mark a design as a finalist' do
    client  = create(:client)
    project = create(:logo_project, client: client, state: Project::STATE_DESIGN_STAGE)
    designs = create_list(:design, 3, project: project)

    login_as(client.user)
    visit "/c/projects/#{project.id}/designs/#{designs.last.id}"

    find('#select-finalist').click
    expect(page).to have_selector('#finalist-modal')

    find('#modal-confirm').click
    expect(page).not_to have_selector('#finalist-modal')

    expect(page).to have_text('FINALIST')
  end

  scenario 'can mark a design as a finalist for stationery' do
    client = create(:client)
    project = create(:brand_identity_project,
                     client: client,
                     state: Project::STATE_DESIGN_STAGE)

    design = create(:design, project: project)

    login_as(client.user)
    visit "/c/projects/#{project.id}/designs/#{design.id}"

    find('#select-finalist').click
    expect(page).to have_selector('#finalist-modal')
    js_click '#modal-confirm'
    expect(page).not_to have_selector('#finalist-modal')
    expect(page).not_to have_selector('#select-finalist')

    design.reload

    expect(design.spot.state.to_sym).to eq(Spot::STATE_STATIONERY)
  end

  scenario 'can not mark a design as a finalist when project in progress' do
    client  = create(:client)
    project = create(:project, client: client, state: Project::STATE_DESIGN_STAGE)
    designs = create_list(:design, 2, project: project)

    login_as(client.user)
    visit "/c/projects/#{project.id}/designs/#{designs.last.id}"

    expect(page).not_to have_selector('#select-finalist')
  end

  scenario 'can block designer' do
    designer = create(:designer)
    project  = create(:project, state: Project::STATE_DESIGN_STAGE)
    design   = create(:design, project: project, designer: designer)

    login_as(project.client.user)
    visit "/c/projects/#{project.id}"
    expect(page).to have_content(designer.display_name)

    visit "/c/projects/#{project.id}/designs/#{design.id}"

    find('#block-designer').click
    expect(page).to have_selector('#block-designer-modal')

    find('#modal-confirm').click
    expect(page).to have_selector('.no-open-modals', visible: false)

    expect(page).to     have_content(project.name)
    expect(page).not_to have_selector('#eliminate-work')
    expect(page).not_to have_selector('#block-designer')
    expect(page).not_to have_content(designer.display_name)
  end

  scenario 'can eliminate design' do
    project = create(:project, state: Project::STATE_DESIGN_STAGE)
    design  = create(:design, project: project)
    client  = project.client

    create(:designer_nda, designer: design.designer, nda: project.nda)

    login_as(client.user)
    visit "/c/projects/#{project.id}/designs/#{design.id}"

    find('#eliminate-work').click
    expect(page).to have_selector('#eliminate-work-modal')

    find('#modal-confirm').click
    expect(page).to have_selector('.no-open-modals', visible: false)

    expect(page).not_to have_selector('#select-finalist')
    expect(page).not_to have_selector('#eliminate-work')
    expect(page).not_to have_selector('#block-designer')

    spot = design.spot.reload

    expect(spot.state).to eq(Spot::STATE_ELIMINATED.to_s)
  end

  scenario 'can approve design' do
    project = create(:brand_identity_project, state: Project::STATE_FINALIST_STAGE)
    design  = create(:stationery_uploaded_design, project: project)
    client  = project.client

    create(:designer_nda, designer: design.designer, nda: project.nda)

    login_as(client.user)

    visit "/c/projects/#{project.id}/designs/#{design.id}"
    find('#approve-design').click

    expect(page).to have_content('FINALIST')
  end

  describe 'winner selection' do
    let(:client) { create(:client) }
    let(:designer) { create(:designer) }

    [
      Project::STATE_DESIGN_STAGE,
      Project::STATE_FINALIST_STAGE
    ].map(&:to_s).each do |state|
      scenario state do
        project = create(:project, client: client, state: state)

        create(:designer_nda, project: project, designer: designer, nda: project.nda)

        finalist_design = create(:finalist_design, project: project, designer: designer)
        winner_design   = create(:finalist_design, project: project, designer: designer)

        login_as(client.user)
        visit "/c/projects/#{project.id}/designs/#{winner_design.id}"

        find('#select-winner').click

        expect(page).to have_selector('#winner-modal')

        find('#modal-confirm').click

        expect(page).to have_selector('.no-open-modals', visible: false)
        expect(page).to have_text('WINNER')

        visit "/c/projects/#{project.id}"
        expect(page).to have_selector('.spinner')

        expect(page).to have_selector("#design-#{winner_design.id}")
        expect(page).not_to have_selector("#design-#{finalist_design.id}")

        visit '/c'
        find('.popover__trigger').click
        find('#logout').click

        login_as(designer.user)
        visit "/d/projects/#{project.id}/designs/#{winner_design.id}"

        expect(page).to have_text('WINNER')
      end
    end
  end
end
