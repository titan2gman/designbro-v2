# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can create project', js: true do
  scenario 'Client proceed with step #2 - Styles' do
    set_encrypted_cookie('project_id', create(:project, state: Project::STATE_WAITING_FOR_STYLE_DETAILS, client: nil).id)

    visit '/projects/new/style'
    expect(page).to have_content 'Tell us which of the following best fit the image'

    click_button 'Continue'
    expect(page).to have_content 'Who is your customer?'
  end

  scenario 'Client proceed with step #3 - Target audience' do
    set_encrypted_cookie('project_id', create(:project, state: Project::STATE_WAITING_FOR_AUDIENCE_DETAILS, client: nil).id)

    visit '/projects/new/audience'
    expect(page).to have_content 'Who is your customer?'

    click_button 'Continue'
    expect(page).to have_content 'Complete the questions and get started!'
  end

  describe 'Client' do
    scenario 'logs in on step #4 - Finish step data' do
      client = create(:client)
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
      set_encrypted_cookie('project_id', project.id)

      visit('/projects/new/finish')

      expect(page).to have_content('Complete the questions and get started!')

      within 'main.sign-in__container' do
        find('span.sign-in__form-link').click
      end

      expect(page).to have_content('Log in now to save your work!')
      expect(page).not_to have_content('Don’t have an account?')

      within 'div.modal-primary' do
        fill_in :email, with: client.email
        fill_in :password, with: 'secret123'

        find('button.sign-in__form-action').click
      end

      expect(page).to have_selector('.no-open-modals', visible: false)
      expect(page).to have_content('Complete the questions and get started!')
      expect(page).not_to have_content('Register to save your progress')
    end

    scenario 'proceed with step #4 - Finish step data (type: logo)' do
      client = create(:client)

      project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: client)
      set_encrypted_cookie('project_id', project.id)

      login_as client.user
      visit('/projects/new/finish')

      expect(page).to have_content('Complete the questions and get started!')

      find('#logos-exist').click

      within '#existingLogos_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[0].id = 'attach_file_0';|)
        attach_file('attach_file_0', Rails.root.join('spec/factories/files/test.png'), visible: false)
        expect(page).to have_selector('.file-uploaded', visible: false)
        fill_in :comment, with: 'existing-logo-comment'
      end

      [:slogan, :brand_name, :additional_text, :company_description, :ideas_or_special_requirements].each do |field|
        fill_in field, with: field.to_s
      end

      find('#competitors-exist').click

      within '#competitors_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[2].id = 'attach_file_2';|)
        attach_file('attach_file_2', Rails.root.join('spec/factories/files/test.png'), visible: false)
        expect(page).to have_selector('.file-uploaded', visible: false)

        fill_in :name, with: 'some name'
        fill_in :comment, with: 'comment'

        all('.icon-star')[4].click
      end

      find('#inspirations-exist').click

      within '#inspirations_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[4].id = 'attach_file_4';|)
        attach_file('attach_file_4', Rails.root.join('spec/factories/files/test.png'), visible: false)
        expect(page).to have_selector('.file-uploaded', visible: false)

        fill_in :comment, with: 'inspiration-comment'
      end

      find('#continue-btn').click

      expect(page).to have_selector('.no-open-modals', visible: false)
      expect(page).to have_content('Continue to Checkout')
    end

    scenario 'should see errors for invalid form for finish step' do
      client = create(:client)
      login_as client.user

      create(:project_price, project_type: :logo, price: 123.5)

      create(
        :logo_project,
        state: Project::STATE_WAITING_FOR_FINISH_DETAILS,
        client: client,
        brand_name: '',
        company_description: ''
      )

      visit '/projects/new/finish'

      find('#competitors-exist').click

      click_button('Continue')

      within('#brand-name__container') do
        expect(page).to have_selector('#brand-name')
        expect(page).to have_content('Required.')
      end

      within('#description__container') do
        expect(page).to have_selector('#description')
        expect(page).to have_content('Required.')
      end

      within('#competitor0-name__container') do
        expect(page).to have_selector('#competitor-name')
        expect(page).to have_content('Required.')
      end

      expect(page).to have_content('Please fill in all required fields')
    end
  end

  describe 'Guest' do
    scenario 'signs up on step #4 - Finish step data' do
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
      set_encrypted_cookie('project_id', project.id)

      visit('/projects/new/finish')

      expect(page).to have_content('Complete the questions and get started!')

      within 'main.sign-in__container' do
        fill_in :email, with: 'client@example.com'
        fill_in :password, with: 'password123'
      end

      find('#continue-btn').click

      expect(page).to have_selector('.no-open-modals', visible: false)
      expect(page).to have_content('Complete the questions and get started!')
      expect(page).not_to have_content('Register to save your progress')
    end

    scenario 'shows server error with step #4 - Finish step data (type: logo)' do
      client = create(:client)
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
      set_encrypted_cookie('project_id', project.id)
      visit('/projects/new/finish')

      expect(page).to have_content('Complete the questions and get started!')

      within 'main.sign-in__container' do
        fill_in :email, with: client.user.email
        fill_in :password, with: 'password123'
      end

      find('#logos-exist').click

      within '#existingLogos_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[0].id = 'attach_file_0';|)
        attach_file('attach_file_0', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :comment, with: 'existing-logo-comment'
      end

      [:slogan, :brand_name, :additional_text, :company_description, :ideas_or_special_requirements].each do |field|
        fill_in field, with: field.to_s
      end

      find('#competitors-exist').click

      within '#competitors_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[2].id = 'attach_file_2';|)
        attach_file('attach_file_2', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :name, with: 'some name'
        fill_in :comment, with: 'comment'

        all('.icon-star')[4].click
      end

      find('#inspirations-exist').click

      within '#inspirations_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[4].id = 'attach_file_4';|)
        attach_file('attach_file_4', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :comment, with: 'inspiration-comment'
      end

      find('#continue-btn').click

      expect(page).to have_content('Complete the questions and get started!')
      expect(page).to have_content('has already been taken')
      expect(page).to have_selector('.no-open-modals', visible: false)
    end

    scenario 'checks logos exist radiobutton if existing design uploaded with step #4 -\
              Finish step data (type: logo)' do
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
      create(:project_existing_logo, project: project)
      set_encrypted_cookie('project_id', project.id)

      visit('/projects/new/finish')

      expect(page).to have_content('Complete the questions and get started!')

      within('#logos-exist') do
        expect(find('.main-radio__input', visible: false)).to be_checked
      end

      expect(page).to have_selector('.no-open-modals', visible: false)
    end

    scenario 'shows weak password error with step #4 - Finish step data (type: logo)' do
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
      set_encrypted_cookie('project_id', project.id)
      visit('/projects/new/finish')

      expect(page).to have_content('Complete the questions and get started!')

      within 'main.sign-in__container' do
        fill_in :password, with: '1'
        fill_in :email, with: 'client@example.com'
      end

      within '.bfs-existing-design' do
        find('label', exact_text: 'Yes').click
      end

      within '#existingLogos_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[0].id = 'attach_file_0';|)
        attach_file('attach_file_0', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :comment, with: 'existing-logo-comment'
      end

      [:slogan, :brand_name, :additional_text, :company_description, :ideas_or_special_requirements].each do |field|
        fill_in field, with: field.to_s
      end

      find('#competitors-exist').click

      within '#competitors_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[2].id = 'attach_file_2';|)
        attach_file('attach_file_2', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :name, with: 'some name'
        fill_in :comment, with: 'comment'

        all('.icon-star')[4].click
      end

      find('#inspirations-exist').click

      within '#inspirations_0_container' do
        execute_script(%|document.querySelectorAll('input[type="file"]')[4].id = 'attach_file_4';|)
        attach_file('attach_file_4', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :comment, with: 'inspiration-comment'
      end

      find('#continue-btn').click

      expect(page).to have_content('Complete the questions and get started!')
      expect(page).to have_content('Password is too weak. Please use stronger one')
      expect(page).to have_selector('.no-open-modals', visible: false)
    end

    scenario 'shows errors with step #4 - Finish step data (type: logo)' do
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
      set_encrypted_cookie('project_id', project.id)
      visit('/projects/new/finish')

      expect(page).to have_content('Complete the questions and get started!')

      find('#continue-btn').click

      expect(page).to have_content('Complete the questions and get started!')
      expect(page).to have_content('Required')
      expect(page).to have_selector('.no-open-modals', visible: false)
      expect(page).not_to have_content('Project details')
    end

    scenario 'proceed with step #4 - Finish step data (type: logo)' do
      project = create(:logo_project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
      set_encrypted_cookie('project_id', project.id)
      visit('/projects/new/finish')

      expect(page).to have_content('Complete the questions and get started!')

      within 'main.sign-in__container' do
        fill_in :email, with: 'client@example.com'
        fill_in :password, with: 'password123'
      end

      expect(page).to have_content('Create your account')
      expect(page).to have_button('Continue', disabled: false)

      find('#logos-exist').click

      within '#existingLogos_0_container' do
        execute_script(%|document.querySelectorAll('#existingLogos_0_container input[type="file"]')[0].id = 'attach_file_0';|)
        attach_file('attach_file_0', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :comment, with: 'existing-logo-comment'
      end

      [:slogan, :brand_name, :additional_text, :company_description, :ideas_or_special_requirements].each do |field|
        fill_in field, with: field.to_s
      end

      find('#competitors-exist').click

      within '#competitors_0_container' do
        execute_script(%|document.querySelectorAll('#competitors_0_container input[type="file"]')[0].id = 'attach_file_2';|)
        attach_file('attach_file_2', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :name, with: 'some name'
        fill_in :comment, with: 'comment'

        all('.icon-star')[4].click
      end

      find('#inspirations-exist').click

      within '#inspirations_0_container' do
        execute_script(%|document.querySelectorAll('#inspirations_0_container input[type="file"]')[0].id = 'attach_file_4';|)
        attach_file('attach_file_4', Rails.root.join('spec/factories/files/test.png'), visible: false)

        fill_in :comment, with: 'inspiration-comment'
      end

      find('#continue-btn').click

      expect(page).to have_content('Continue to Checkout')
      expect(page).to have_selector('.no-open-modals', visible: false)
    end

    scenario 'should see errors for invalid form for finish step' do
      create(:project_price, project_type: :logo, price: 123.5)
      project = create(
        :logo_project,
        state: Project::STATE_WAITING_FOR_FINISH_DETAILS,
        client: nil,
        brand_name: '',
        company_description: ''
      )

      set_encrypted_cookie('project_id', project.id)

      visit '/projects/new/finish'

      find('#competitors-exist').click

      click_button('Continue')

      within('#email__container') do
        expect(page).to have_selector('#email')
        expect(page).to have_content('Required.')
      end

      within('#password__container') do
        expect(page).to have_selector('#password')
        expect(page).to have_content('Required.')
      end

      within('#brand-name__container') do
        expect(page).to have_selector('#brand-name')
        expect(page).to have_content('Required.')
      end

      within('#description__container') do
        expect(page).to have_selector('#description')
        expect(page).to have_content('Required.')
      end

      within('#competitor0-name__container') do
        expect(page).to have_selector('#competitor-name')
        expect(page).to have_content('Required.')
      end

      expect(page).to have_content('Please fill in all required fields')
    end
  end
end
