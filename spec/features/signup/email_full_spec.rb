# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'User can signup (full feature)', :js do
  describe 'Designer' do
    scenario 'signs up' do
      display_name = 'pikachu'
      email = 'text@gmail.com'
      password = 'pass12345'

      visit '/d/signup'
      fill_in :displayName, with: display_name
      fill_in :email, with: email
      fill_in :password, with: password

      check('Allow DesignBro to send you emails relating to the functioning of the platform as well as marketing', allow_label_click: true)
      click_button 'Join as a Designer'

      expect(page).to have_content('Welcome to DesignBro! It’s great to see you here!')
      expect(page).to have_selector('.join-profile-info')

      expect(emails_sent_to(email)).to be_empty

      create(:designer)

      designer_attrs = attributes_for(:designer)
      fill_in :firstName, with: designer_attrs[:first_name]
      fill_in :lastName, with: designer_attrs[:last_name]
      fill_in :country, with: 'Ukraine'
      find('li div', text: 'Ukraine', exact_text: true).click
      dropdown_select 'January', from: "div[name='dateOfBirthMonth']"
      fill_in :dateOfBirthDay, with: '10'
      fill_in :dateOfBirthYear, with: '1990'
      dropdown_select 'Female', from: "div[name='gender']"
      dropdown_select '1-3 years', from: "div[name='1']"
      dropdown_select 'No experience', from: "div[name='2']"
      dropdown_select 'Good', from: "div[name='experienceEnglish']"

      click_button 'Next Step'
      expect(page).to have_selector('.join-upload-portfolio')

      within('section.join-profile-info__group', text: 'Brand Identity') do
        4.times do |i|
          page.all(:css, 'div.upload-box') do
            execute_script %|document.querySelectorAll('input[type="file"]')[#{i}].id = 'attach_file_#{i}';|
            attach_file("attach_file_#{i}", Rails.root.join('spec/factories/files/test.png'), visible: false)
            expect(page).to have_selector('.file-uploaded', visible: false)
            # page.all(:css, 'textarea.main-input__textarea').find('textarea').set('description')
            # elem.sibling('textarea.main-input__textarea').find('textarea').set('description')
          end

          page.all('textarea.main-input__textarea').each { |node| node.set('text') }

          # page.all('div.upload-box__description') do |elem|
          #   elem.find('textarea').set('text')
          # end
        end
      end

      click_button 'Submit Portfolio'
      expect(page).to have_selector('.main-modal')
      within '.main-modal' do
        js_click '#share-modal-submit'
      end

      expect(page).to have_selector('.join-complete')
      expect(page).to have_content('Great, thank you!')
    end
  end

  describe 'Client' do
    describe 'finishes project flow' do
      scenario 'signs up on finish details step of project creation' do
        email = Faker::Internet.email
        password = Faker::Internet.password

        create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
        # set_encrypted_cookie('project_id', project.id)

        visit '/projects/new/finish'

        fill_in :email, with: email
        fill_in :password, with: password

        click_button('Continue')

        expect(page).to have_content('Last Questions')
        expect(page).to have_css('.no-open-modals', visible: false)
        # expect(page).not_to have_content('Register to save your progress')
      end

      scenario 'should save project for second sign up (after email taken error)' do
        # project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
        # set_encrypted_cookie('project_id', project.id)

        email = Faker::Internet.email
        password = Faker::Internet.password
        user = create(:user, email: email)
        create(:client, user: user)

        visit '/projects/new/finish'

        fill_in :email, with: email
        fill_in :password, with: password

        click_button('Continue')

        expect(page).to have_content('has already been taken')

        new_email = Faker::Internet.email

        fill_in :email, with: new_email, fill_options: { clear: :backspace }
        fill_in :password, with: password, fill_options: { clear: :backspace }

        click_button('Continue')

        expect(page).to have_content('Continue to Checkout')
        expect(page).to have_css('.no-open-modals', visible: false)
        expect(page).not_to have_content('Create your account')

        project.reload

        expect(project.client).not_to be_nil
      end
    end

    describe 'does not finish project flow' do
      scenario 'sees the second project flow step' do
        email = Faker::Internet.email
        password = Faker::Internet.password

        # project = create(:project, state: Project::STATE_WAITING_FOR_STYLE_DETAILS, client: nil)
        # set_encrypted_cookie('project_id', project.id)

        visit '/c/signup'

        fill_in :email, with: email
        fill_in :password, with: password

        click_button 'Sign up as a Client'
        expect(page).to have_content('Describe your brand identity')

        expect(emails_sent_to(email)).to be_empty
      end

      scenario 'sees the third project flow step' do
        email = Faker::Internet.email
        password = Faker::Internet.password(10)

        # project = create(:project, state: Project::STATE_WAITING_FOR_AUDIENCE_DETAILS, client: nil)
        # set_encrypted_cookie('project_id', project.id)

        visit '/c/signup'

        fill_in :email, with: email
        fill_in :password, with: password

        click_button 'Sign up as a Client'
        expect(page).to have_content('Tell us about your target audience')

        expect(emails_sent_to(email)).to be_empty
      end

      scenario 'sees the fourth project flow step' do
        email = Faker::Internet.email
        password = Faker::Internet.password

        # project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
        # set_encrypted_cookie('project_id', project.id)

        visit '/c/signup'

        fill_in :email, with: email
        fill_in :password, with: password

        click_button 'Sign up as a Client'
        expect(page).to have_content('Last Questions')

        expect(emails_sent_to(email)).to be_empty
      end

      scenario 'does not see public project flow after another client' do
        email = Faker::Internet.email
        password = Faker::Internet.password

        # project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
        # set_encrypted_cookie('project_id', project.id)

        visit('/c/signup')

        fill_in(:email, with: email)
        fill_in(:password, with: password)

        click_button('Sign up as a Client')
        expect(page).to have_content('Last Questions')

        expect(emails_sent_to(email)).to be_empty

        find('.main-userpic-md').click
        find('#logout').click

        # another user logins below

        user = create(:client).user
        fill_in(:email, with: user.email)
        fill_in(:password, with: user.password)

        click_button('Log in')

        expect(page).to have_content('My Projects')
        expect(page).not_to have_content('Last Questions')
      end
    end
  end
end
