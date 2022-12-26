# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Winner selection', js: true do
  context 'Client can select winner' do
    context 'for project without stationery' do
      scenario 'with one finalist (state: :design_stage)' do
        project = create(:project, state: Project::STATE_DESIGN_STAGE, project_type: [:logo, :packaging].sample)

        create_list(:design, 2, project: project)
        create(:finalist_design, project: project)

        login_as(project.client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)

        first('.preview-frame-menu').click
        all('span', text: 'Winner').last.click

        expect(page).to have_selector('#winner-modal')

        find('#modal-confirm').click

        expect(page).to have_selector('.no-open-modals', visible: false)
        expect(page).to have_content('WINNER')
      end

      scenario 'with one finalist (state: :finalist_stage)' do
        project = create(:project, state: Project::STATE_FINALIST_STAGE, project_type: [:logo, :packaging].sample)

        create_list(:design, 2, project: project)
        create(:finalist_design, project: project)

        login_as(project.client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)

        first('.preview-frame-menu').click
        all('span', text: 'Winner').last.click

        expect(page).to have_selector('#winner-modal')

        find('#modal-confirm').click

        expect(page).to have_selector('.no-open-modals', visible: false)
        expect(page).to have_content('WINNER')
      end

      scenario 'with three finalist' do
        project = create(:project, state: Project::STATE_FINALIST_STAGE, project_type: [:logo, :packaging].sample)
        design  = create(:design, project: project)
        create_list(:finalist_design, 3, project: project)

        login_as(project.client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)
        expect(page).not_to have_content(design.name)

        first('.preview-frame-menu').click
        all('span', text: 'Winner').last.click

        expect(page).to have_selector('#winner-modal')

        find('#modal-confirm').click

        expect(page).to have_selector('.no-open-modals', visible: false)
        expect(page).to have_content('WINNER')
      end
    end

    context 'for project with stationery' do
      scenario 'with one finalist (state: :design_stage)' do
        project = create(:brand_identity_project, state: Project::STATE_DESIGN_STAGE)
        create_list(:design, 2, project: project)
        create(:stationery_uploaded_design, project: project)

        login_as(project.client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)

        first('.preview-frame-menu').click
        all('span', text: 'Approve').last.click

        expect(page).to have_content('Winner')
      end

      scenario 'with one finalist (state: :finalist_stage)' do
        project = create(:brand_identity_project, state: Project::STATE_FINALIST_STAGE)
        create_list(:design, 2, project: project)
        create(:stationery_uploaded_design, project: project)

        login_as(project.client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)

        first('.preview-frame-menu').click
        all('span', text: 'Approve').last.click

        expect(page).to have_content('Winner')
      end

      scenario 'with three finalist' do
        project = create(:brand_identity_project, state: Project::STATE_FINALIST_STAGE)
        design  = create(:design, project: project)

        create_list(:stationery_uploaded_design, 3, project: project)

        login_as(project.client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)
        expect(page).not_to have_content(design.name)

        first('.preview-frame-menu').click
        all('span', text: 'Approve').last.click

        expect(page).to have_content('Winner')
      end
    end
  end

  context 'God Client cannot select winner' do
    let(:client) { create(:god_client) }

    context 'for project without stationery' do
      scenario 'with one finalist (state: :design_stage)' do
        project = create(:project, state: Project::STATE_DESIGN_STAGE, project_type: [:logo, :packaging].sample)

        create_list(:design, 2, project: project)
        create(:finalist_design, project: project)

        login_as(client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)

        first('.preview-frame-menu').click
        all('span', text: 'Winner').last.click

        expect(page).to have_selector('#winner-modal')

        find('#modal-confirm').click

        expect(page).to have_selector('.no-open-modals', visible: false)
        expect(page).to have_content('FINALIST')
        expect(page).not_to have_content('WINNER')
      end

      scenario 'with one finalist (state: :finalist_stage)' do
        project = create(:project, state: Project::STATE_FINALIST_STAGE, project_type: [:logo, :packaging].sample)

        create_list(:design, 2, project: project)
        create(:finalist_design, project: project)

        login_as(client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)

        first('.preview-frame-menu').click
        all('span', text: 'Winner').last.click

        expect(page).to have_selector('#winner-modal')

        find('#modal-confirm').click

        expect(page).to have_selector('.no-open-modals', visible: false)
        expect(page).to have_content('FINALIST')
        expect(page).not_to have_content('WINNER')
      end

      scenario 'with three finalist' do
        project = create(:project, state: Project::STATE_FINALIST_STAGE, project_type: [:logo, :packaging].sample)
        design  = create(:design, project: project)
        create_list(:finalist_design, 3, project: project)

        login_as(client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)
        expect(page).not_to have_content(design.name)

        first('.preview-frame-menu').click
        all('span', text: 'Winner').last.click

        expect(page).to have_selector('#winner-modal')

        find('#modal-confirm').click

        expect(page).to have_selector('.no-open-modals', visible: false)
        expect(page).to have_content('FINALIST')
        expect(page).not_to have_content('WINNER')
      end
    end

    context 'for project with stationery' do
      scenario 'with one finalist (state: :design_stage)' do
        project = create(:brand_identity_project, state: Project::STATE_DESIGN_STAGE)
        create_list(:design, 2, project: project)
        create(:stationery_uploaded_design, project: project)

        login_as(client.user)

        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)

        first('.preview-frame-menu').click
        all('span', text: 'Approve').last.click

        visit "/c/projects/#{project.id}"
        first('.preview-frame-menu').click

        expect(page).to have_content('Approve')
        expect(page).not_to have_content('Winner')
      end

      scenario 'with one finalist (state: :finalist_stage)' do
        project = create(:brand_identity_project, state: Project::STATE_FINALIST_STAGE)
        create_list(:design, 2, project: project)
        create(:stationery_uploaded_design, project: project)

        login_as(client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)

        first('.preview-frame-menu').click
        all('span', text: 'Approve').last.click

        visit "/c/projects/#{project.id}"
        first('.preview-frame-menu').click

        expect(page).to have_content('Approve')
        expect(page).not_to have_content('Winner')
      end

      scenario 'with three finalist' do
        project = create(:brand_identity_project, state: Project::STATE_FINALIST_STAGE)
        design  = create(:design, project: project)

        create_list(:stationery_uploaded_design, 3, project: project)

        login_as(client.user)
        visit "/c/projects/#{project.id}"
        expect(page).to have_content(project.name)
        expect(page).not_to have_content(design.name)

        first('.preview-frame-menu').click
        all('span', text: 'Approve').last.click

        visit "/c/projects/#{project.id}"
        first('.preview-frame-menu').click

        expect(page).to have_content('Approve')
        expect(page).not_to have_content('Winner')
      end
    end
  end
end
