# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Ability to create packaging project', js: true do
  describe 'guest' do
    describe 'can create `plastic-pack` project' do
      it 'via uploading technical drawing' do
        visit '/projects/new/packaging-type'
        expect(page).to have_content('Tell us which of the following you would like to design on:')

        find('#plastic-pack-packaging-type').click

        expect(page).to have_content('Plastic pack measurements')

        execute_script(%|document.querySelectorAll('input[type="file"]')[0].id = 'attach_file_0';|)
        attach_file('attach_file_0', Rails.root.join('spec/factories/files/test.png'), visible: false)

        expect(page).to have_selector('.file-uploaded', visible: false)

        find('#continue-btn').click

        expect(page).to have_content 'Describe your brand identity'

        project = Project.last
        expect(project.project_type).to eq 'packaging'
        expect(project.state).to eq 'waiting_for_style_details'

        measurements = project.packaging_measurements
        expect(measurements.packaging_type).to eq :plastic_pack
        expect(measurements.technical_drawing).not_to be_nil
      end
    end

    [:waiting_for_style_details, :waiting_for_finish_details, :waiting_for_audience_details].each do |state|
      it "can see current page of project that was created before (state: #{state})" do
        project = create(:project, state: state, project_type: :packaging, client: nil)
        create(:plastic_pack_packaging_measurements, project: project)

        set_encrypted_cookie('project_id', project.id)

        visit NEW_PROJECT_STEP_LINK[state]

        expect(page).to have_content(NEW_PROJECT_STEP_CONTENT[state])
      end

      it "can see first page of project that was created before (state: #{state})" do
        project = create(:project, state: state, project_type: :packaging, client: nil)
        create(:plastic_pack_packaging_measurements, project: project)

        set_encrypted_cookie('project_id', project.id)

        visit '/projects/new/packaging-type'

        expect(page).to have_content 'Plastic pack measurements'
      end
    end

    scenario 'should see errors for invalid form for packaging type step' do
      project = create(:packaging_project, state: Project::STATE_DRAFT, client: nil)
      set_encrypted_cookie('project_id', project.id)

      visit '/projects/new/packaging-type'

      find('#plastic-pack-packaging-type').click
      expect(page).to have_content('Plastic pack measurements')

      click_button('Continue')

      expect(page).to have_content('Please upload technical drawing.')
      expect(page).to have_content('Please fill in all required fields')
    end
  end

  describe 'client' do
    describe 'can create `plastic-pack` project' do
      it 'via uploading technical drawing' do
        client = create(:client)
        login_as client.user

        visit '/projects/new/packaging-type'
        expect(page).to have_content('Tell us which of the following you would like to design on:')

        find('#plastic-pack-packaging-type').click

        expect(page).to have_content('Plastic pack measurements')

        execute_script(%|document.querySelectorAll('input[type="file"]')[0].id = 'attach_file_0';|)
        attach_file('attach_file_0', Rails.root.join('spec/factories/files/test.png'), visible: false)

        expect(page).to have_selector('.file-uploaded', visible: false)

        find('#continue-btn').click

        expect(page).to have_content 'Describe your brand identity'

        project = Project.where(client: client).last
        expect(project.project_type).to eq 'packaging'
        expect(project.state).to eq 'waiting_for_style_details'

        measurements = project.packaging_measurements
        expect(measurements.packaging_type).to eq :plastic_pack
        expect(measurements.technical_drawing).not_to be_nil
      end
    end

    [:waiting_for_style_details, :waiting_for_finish_details, :waiting_for_audience_details].each do |state|
      it "can see current page of project that was created before (state: #{state})" do
        client = create(:client)
        login_as client.user

        project = create(:project, state: state, project_type: :packaging, client: client)
        create(:plastic_pack_packaging_measurements, project: project)

        set_encrypted_cookie('project_id', project.id)

        visit NEW_PROJECT_STEP_LINK[state]

        expect(page).to have_content(NEW_PROJECT_STEP_CONTENT[state])
      end

      it "can see first page of project that was created before (state: #{state})" do
        client = create(:client)
        login_as client.user

        project = create(:project, state: state, project_type: :packaging, client: client)
        create(:plastic_pack_packaging_measurements, project: project)

        set_encrypted_cookie('project_id', project.id)

        visit '/projects/new/packaging-type'

        expect(page).to have_content 'Plastic pack measurements'
      end
    end

    scenario 'should see errors for invalid form for packaging type step' do
      client = create(:client)
      login_as client.user

      project = create(:packaging_project, state: Project::STATE_DRAFT, client: client)
      set_encrypted_cookie('project_id', project.id)

      visit '/projects/new/packaging-type'

      find('#plastic-pack-packaging-type').click
      expect(page).to have_content('Plastic pack measurements')

      click_button('Continue')

      expect(page).to have_content('Please upload technical drawing.')
      expect(page).to have_content('Please fill in all required fields')
    end
  end

  describe 'designer' do
    it 'should be redirected to dashboard' do
      login_as create(:designer).user
      visit '/projects/new/packaging-type'

      expect(page).not_to have_content 'Tell us which of the following'
    end
  end
end
