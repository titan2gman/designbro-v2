# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Checkout Step #2 - Billing Address', js: true do
  before do
    allow(Stripe::Charge).to receive(:create)
    allow(InvoiceJob).to receive(:perform_later)
  end

  describe 'guest' do
    ['/c', '/c/projects', '/c/projects/new', '/c/projects/new/checkout'].each do |url|
      scenario "should be redirected to login page when visit: #{url}" do
        visit url
        expect(page).to have_content('Log in')
      end
    end
  end

  describe 'designer' do
    ['/c', '/c/projects', '/c/projects/new', '/c/projects/new/checkout'].each do |url|
      scenario "should be redirected to designer dashboard when visit: #{url}" do
        designer = create(:designer)
        login_as designer.user

        visit url

        expect(page).to have_content('Discover Projects')
      end
    end
  end

  describe 'client' do
    scenario 'should be redirected to the first step if that step was omit' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/checkout'

      expect(page).to have_content('Continue to Checkout')
    end

    scenario 'should be redirected to the dashboard if there is no project to checkout' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_DESIGN_STAGE, client: client)

      visit '/c/projects/new/checkout'

      expect(page).to have_content('My Projects')
    end

    scenario 'should be redirected to the dashboard (project_state: Project::STATE_WAITING_FOR_PAYMENT)' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_PAYMENT, client: client)

      visit '/c/projects/new/checkout'

      expect(page).to have_content('My Projects')
    end

    scenario 'should see logo project in checkout details block' do
      client = create(:client)
      login_as client.user

      create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

      visit '/c/projects/new/checkout'

      expect(page).to have_content('Logo Design')
      expect(page).not_to have_content('Upgrade your package')
      expect(page).to have_selector('[name=business-customer]', visible: false)
    end

    scenario 'should see upgrade package of logo project in checkout details block' do
      client = create(:client)
      login_as client.user

      create(:project_price, project_type: :logo)
      create(:project_price, project_type: :brand_identity)
      create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client, upgrade_package: true)

      visit '/c/projects/new/checkout'

      expect(page).to have_content('Logo Design')
      expect(page).not_to have_content('Upgrade your package')
      expect(page).to have_content('Upgrade pack')
      expect(page).to have_selector('[name=business-customer]', visible: false)
    end

    scenario 'should see packaging project in checkout details block' do
      client = create(:client)
      login_as client.user

      create(:packaging_project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

      visit '/c/projects/new/checkout'

      expect(page).to have_content('Packaging Design')
      expect(page).not_to have_content('Upgrade your package')
      expect(page).to have_selector('[name=business-customer]', visible: false)
    end

    scenario 'should see brand identity project in checkout details block' do
      client = create(:client)
      login_as client.user

      create(:brand_identity_project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

      visit '/c/projects/new/checkout'

      expect(page).to have_content('Identity Pack')
      expect(page).not_to have_content('Upgrade your package')
      expect(page).to have_selector('[name=business-customer]', visible: false)
    end

    scenario 'should see discount of project in checkout block' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

      visit '/c/projects/new/checkout'

      expect(page).to have_content('Discount')

      expect(page).to have_selector('[name=business-customer]', visible: false)
    end

    scenario 'can add discount to project' do
      client = create(:client)
      login_as client.user

      create(:discount)
      create(:project_price, project_type: :logo, price: 123.5)
      create(
        :logo_project,
        state: Project::STATE_WAITING_FOR_CHECKOUT,
        client: client,
        discount: nil,
        discount_amount: 0
      )

      visit '/c/projects/new/checkout'

      expect(page).to have_content('Billing Address')

      expect(page).to have_selector('[name=business-customer]', visible: false)
    end

    describe 'testimonials' do
      scenario 'should see testimonial if exists' do
        client = create(:client)
        testimonial = create(:testimonial)
        login_as client.user

        create(:project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

        visit '/c/projects/new/checkout'

        expect(page).to have_css('div[class="prjb-comment prjb-info-block bg-grey-50"]')
        expect(page).to have_content(testimonial.body)
      end

      scenario 'should not see testimonial' do
        client = create(:client)
        login_as client.user

        create(:project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

        visit '/c/projects/new/checkout'

        expect(page).not_to have_css('div[class="prjb-comment prjb-info-block bg-grey-50"]')
      end
    end

    describe 'should fill all fields and submit form' do
      describe 'bank transfer' do
        scenario 'logo' do
          client = create(:client)
          login_as client.user

          create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, business_customer: true, client: client)
          billing_address = attributes_for(:eu_billing_address)
          create(:united_kingdom_vat_rate)
          create(:logo_project_price)

          visit '/c/projects/new/checkout'

          expect(page).to have_selector('[name=company]', visible: false)

          [:first_name, :last_name, :company, :vat].each do |property|
            fill_in property.to_s.dasherize, with: billing_address[property]
          end

          fill_in 'country', with: 'United Kingdom'
          find('li', exact_text: 'United Kingdom').click

          find('label', exact_text: 'Bank transfer').click

          click_button('Complete Order')

          expect(page).to have_content('Please complete the transfer now')
          expect(page).to have_content('Go to my projects')
        end

        scenario 'packaging' do
          client = create(:client)
          login_as client.user

          create(:packaging_project, state: Project::STATE_WAITING_FOR_CHECKOUT, business_customer: true, client: client)
          billing_address = attributes_for(:eu_billing_address)
          create(:united_kingdom_vat_rate)
          create(:packaging_project_price)

          visit '/c/projects/new/checkout'

          expect(page).to have_selector('[name=company]', visible: false)

          [:first_name, :last_name, :company, :vat].each do |property|
            fill_in property.to_s.dasherize, with: billing_address[property]
          end

          fill_in 'country', with: 'United Kingdom'
          find('li', exact_text: 'United Kingdom').click

          find('label', exact_text: 'Bank transfer').click

          click_button('Complete Order')

          expect(page).to have_content('Please complete the transfer now')
          expect(page).to have_content('Go to my projects')
        end

        scenario 'brand identity' do
          client = create(:client)
          login_as client.user

          create(:brand_identity_project, state: Project::STATE_WAITING_FOR_CHECKOUT, business_customer: true, client: client)
          billing_address = attributes_for(:eu_billing_address)
          create(:brand_identity_project_price)
          create(:united_kingdom_vat_rate)

          visit '/c/projects/new/checkout'

          expect(page).to have_selector('[name=company]', visible: false)

          [:first_name, :last_name, :company, :vat].each do |property|
            fill_in property.to_s.dasherize, with: billing_address[property]
          end

          fill_in 'country', with: 'United Kingdom'
          find('li', exact_text: 'United Kingdom').click

          find('label', exact_text: 'Bank transfer').click

          click_button('Complete Order')

          expect(page).to have_content('Please complete the transfer now')
          expect(page).to have_content('Next')
        end

        scenario 'should see errors for invalid form for checkout step' do
          client = create(:client)
          login_as client.user

          create(:project_price, project_type: :logo, price: 123.5)
          create(
            :logo_project,
            state: Project::STATE_WAITING_FOR_CHECKOUT,
            client: client,
            billing_address: nil
          )

          visit '/c/projects/new/checkout'

          find('label', exact_text: 'Bank transfer').click

          click_button('Complete Order')

          within('#country__container') do
            expect(page).to have_selector('#country')
            expect(page).to have_content('Required.')
          end
        end
      end
    end
  end
end
