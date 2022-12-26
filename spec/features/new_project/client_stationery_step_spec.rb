# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Checkout Step #4 - Stationery', js: true do
  describe 'guest' do
    ['/c', '/c/projects', '/c/projects/new', '/c/projects/new/stationery'].each do |url|
      scenario "should be redirected to login page when visit: #{url}" do
        visit url
        expect(page).to have_content('Log in')
      end
    end
  end

  describe 'designer' do
    ['/c', '/c/projects', '/c/projects/new', '/c/projects/new/stationery'].each do |url|
      scenario "should be redirected to designer dashboard when visit: #{url}" do
        designer = create(:designer)
        login_as designer.user

        visit url

        expect(page).to have_content('Discover Projects')
      end
    end
  end

  describe 'client' do
    describe 'should be redirected to the stationery step from' do
      ['/c/projects/new/details', '/c/projects/new/checkout'].each do |url|
        scenario url do
          client = create(:client)
          login_as client.user

          create(:project, state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS, client: client)

          visit url

          expect(page).to have_content('Brand Identity Design Brief')
          expect(page).to have_content('Please fill the stationery brief')

          expect(page).not_to have_content('Thank you for your payment')
        end
      end
    end

    scenario 'should be redirected to the first step if that step was omit' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/stationery'

      expect(page).to have_content('Continue to Checkout')
    end

    scenario 'should be redirected to the second step if that step was omit' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

      visit '/c/projects/new/stationery'

      expect(page).to have_content('Billing Address')
      expect(page).to have_current_path('/c/projects/new/checkout')
    end

    scenario 'should be redirected to the dashboard if there is no project to checkout' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_DESIGN_STAGE, client: client)

      visit '/c/projects/new/stationery'

      expect(page).to have_content('My Projects')
    end

    describe 'should fill all fields and submit form' do
      scenario 'payment_type: :credit_card' do
        client = create(:client)
        login_as client.user

        project = create(:brand_identity_project, state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS, client: client)
        create(:credit_card_payment, project: project)

        visit '/c/projects/new/stationery'

        ['card-front', 'card-back', 'letterhead', 'compliment'].each do |value|
          fill_in value, with: value
        end

        click_button('Finish')

        expect(page).to have_content('My Projects')
        expect(page).to have_content(project.name)
      end

      scenario 'payment_type: :bank_transfer' do
        client = create(:client)
        login_as client.user

        project = create(
          :brand_identity_project,
          state: Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS,
          client: client
        )
        create(:bank_transfer_payment, project: project)

        visit '/c/projects/new/stationery'

        ['card-front', 'card-back', 'letterhead', 'compliment'].each do |value|
          fill_in value, with: value
        end

        click_button('Finish')

        expect(page).to have_content('My Projects')
        expect(page).not_to have_content(project.name)
      end

      scenario 'with approved payment and payment_type: :bank_transfer' do
        client = create(:client)
        login_as client.user

        project = create(:brand_identity_project, state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS, client: client)
        create(:bank_transfer_payment, project: project)

        visit '/c/projects/new/stationery'

        ['card-front', 'card-back', 'letterhead', 'compliment'].each do |value|
          fill_in value, with: value
        end

        click_button('Finish')

        expect(page).to have_content('My Projects')
        expect(page).to have_content(project.name)
      end

      scenario 'should see errors for invalid form for stationery step' do
        client = create(:client)
        login_as client.user

        create(:project_price, project_type: :brand_identity, price: 123.5)
        create(
          :brand_identity_project,
          state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
          client: client,
          front_business_card_details: nil,
          back_business_card_details: nil,
          letter_head: nil,
          compliment: nil
        )

        visit '/c/projects/new/stationery'

        click_button('Finish')

        within('#card-front__container') do
          expect(page).to have_selector('#card-front')
          expect(page).to have_content('Required.')
        end

        within('#card-back__container') do
          expect(page).to have_selector('#card-back')
          expect(page).to have_content('Required.')
        end

        within('#letterhead__container') do
          expect(page).to have_selector('#letterhead')
          expect(page).to have_content('Required.')
        end

        within('#compliment__container') do
          expect(page).to have_selector('#compliment')
          expect(page).to have_content('Required.')
        end
      end
    end
  end
end
