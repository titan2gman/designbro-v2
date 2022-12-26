# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Checkout Step #1 - Project Details', js: true do
  describe 'guest' do
    ['/c', '/c/projects', '/c/projects/new', '/c/projects/new/details'].each do |url|
      scenario "should be redirected to login page when visit: #{url}" do
        visit url
        expect(page).to have_content('Log in')
      end
    end
  end

  describe 'designer' do
    ['/c', '/c/projects', '/c/projects/new', '/c/projects/new/details'].each do |url|
      scenario "should be redirected to designer dashboard when visit: #{url}" do
        designer = create(:designer)
        login_as designer.user

        visit url

        expect(page).to have_content('Discover Projects')
      end
    end
  end

  describe 'client' do
    scenario 'should be redirected to the dashboard if there is no project to checkout' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_DESIGN_STAGE, client: client)

      visit '/c/projects/new/details'

      expect(page).to have_content('My Projects')
    end

    scenario 'should be redirected to the dashboard (project_state: :waiting_for_payment)' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_PAYMENT, client: client)

      visit '/c/projects/new/details'

      expect(page).to have_content('My Projects')
    end

    scenario 'should be redirected to the finish details on "Back" button click' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/details'

      click_button('Back')

      expect(page).to have_content('Last Questions')
    end

    scenario 'should see logo project in checkout details block' do
      client = create(:client)
      login_as client.user

      create(:logo_project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/details'

      expect(page).to have_content('Logo Design')
      expect(page).to have_content('Do you need business card & more?')
    end

    scenario 'should see packaging project in checkout details block' do
      client = create(:client)
      login_as client.user

      create(:packaging_project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/details'

      expect(page).to have_content('Packaging Design')
      expect(page).not_to have_content('Do you need business card & more?')
    end

    describe 'testimonials' do
      scenario 'should see testimonial if exists' do
        client = create(:client)
        testimonial = create(:testimonial)
        login_as client.user

        create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

        visit '/c/projects/new/details'

        expect(page).to have_css('div[class="prjb-comment prjb-info-block bg-grey-50"]')
        expect(page).to have_content(testimonial.body)
      end

      scenario 'should not see testimonial' do
        client = create(:client)
        login_as client.user

        create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

        visit '/c/projects/new/details'

        expect(page).not_to have_css('div[class="prjb-comment prjb-info-block bg-grey-50"]')
      end
    end

    scenario 'should show frequently asked hint' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/details'

      expect(page).to have_content('frequently asked:')
      expect(page).to have_content("what if i don't like a design?")
      find('button', text: "what if i don't like a design?").click

      expect(page).to have_css('div[class="modal-primary__body-block conv-confirmation-modal-primary-body-block"]')
      expect(page).to have_content('We got you covered.')
      expect(page).to have_content("When you don't like a specific design, you can simply eliminate it. This will open the spot again for another designer to join as long as the project runs.")
      expect(page).to have_content('Read more about eliminating designs here')
      expect(page).to have_content('Got it')
      expect(page).to have_selector(:css, 'a[href="https://designbro.com/tips-tricks-logo-project/"]')
    end

    scenario 'should see brand identity project in checkout details block' do
      client = create(:client)
      login_as client.user

      create(:brand_identity_project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/details'

      expect(page).to have_content('Identity Pack')
      expect(page).not_to have_content('Upgrade your package')
    end

    scenario 'should see data about project when comes back to details step (logo project)' do
      client = create(:client)
      login_as client.user

      project = create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client, max_spots_count: 5)
      create(:logo_additional_design_price, quantity: 5, amount: 84)
      create(:billing_address, project: project)

      visit '/c/projects/new/details'

      expect(page).to have_content('Logo Design')

      expect(page).to have_field('project-name', with: project.name)
      expect(page).to have_field('project-description', with: project.description)

      expect(find('.prj-designs-count')).to have_selector('span', text: 5)
      expect(find('.prj-designs-count')).to have_selector('span', text: '(+$84)')

      expect(page).to have_selector('[name=upgrade-package]', visible: false)
    end

    scenario 'should fill all fields and submit form' do
      client = create(:client)
      login_as client.user

      create(:free_nda_price)
      create(:united_kingdom_vat_rate)
      create(:logo_project_price, price: 100)
      create(:brand_identity_project_price, price: 300)
      create(:logo_project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/details'

      ['project-name', 'project-description'].each do |field|
        fill_in field, with: 'some-text-here'
      end

      within('.upgrade-package') do
        find('label', exact_text: 'Yes').click
      end

      within('.prjb-nda') do
        find('label', exact_text: 'Yes').click
        find('label', text: 'standard').click
      end

      click_button('Continue')

      expect(page).to have_content('Billing Address')
      expect(page).to have_current_path('/c/projects/new/checkout')
    end

    scenario 'should see discount of project in checkout details block' do
      client = create(:client)
      login_as client.user

      create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

      visit '/c/projects/new/details'

      expect(page).to have_content('Discount')
      expect(page).to have_content('NDA')
    end

    scenario 'can add discount to project' do
      client = create(:client)
      login_as client.user

      discount = create(:discount)
      create(:free_nda_price)
      create(:project_price, project_type: :logo, price: 123.5)
      create(
        :logo_project,
        state: Project::STATE_WAITING_FOR_DETAILS,
        client: client,
        discount: nil,
        discount_amount: 0
      )

      visit '/c/projects/new/details'

      expect(page).to have_content('NDA')
      within('.prjb-info-block__body') do
        expect(page).not_to have_content('Discount')
      end

      find('#discount-code').set(discount.code)

      expect(page).to have_content('Discount')
    end

    scenario 'should calclulate discount in proper way' do
      client = create(:client)
      login_as client.user

      discount = create(:discount, discount_type: :percent, value: 80)
      create(:free_nda_price)
      create(:project_price, project_type: :brand_identity, price: 399)
      project = create(
        :brand_identity_project,
        state: Project::STATE_WAITING_FOR_DETAILS,
        client: client,
        max_spots_count: 9,
        discount: nil,
        discount_amount: 0
      )

      # TODO: pay attention and fix
      # For no reason UI doesn't display created brand_identity_additional_design_price
      # create(:brand_identity_additional_design_price,
      #        quantity: 9,
      #        amount: 255,
      #        project_price: project_price)

      expected_discount = (project.project_type_price * discount.value) / 100
      visit '/c/projects/new/details'
      expect(page).to have_content('Identity Pack')
      find('#discount-code').set(discount.code)

      within('.prjb-nda') do
        find('label', exact_text: 'No').click
      end

      expect(page).to have_content('Discount')
      expect(page).to have_content(format('- $%<expected_discount>0.2f', expected_discount: expected_discount.to_f))
      expect(page).to have_content(format('$%<diff>0.2f', diff: (project.project_type_price - expected_discount).to_f))
    end

    scenario 'should see errors for invalid form for details step' do
      client = create(:client)
      login_as client.user

      create(:project_price, project_type: :logo, price: 123.5)
      create(
        :logo_project,
        state: Project::STATE_WAITING_FOR_DETAILS,
        client: client,
        company_description: '',
        background_story: nil,
        description: nil,
        brand_name: '',
        name: nil
      )

      visit '/c/projects/new/details'

      click_button('Continue')

      within('#project-name__container') do
        expect(page).to have_selector('#project-name')
        expect(page).to have_content('Required.')
      end

      within('#project-description__container') do
        expect(page).to have_selector('#project-description')
        expect(page).to have_content('Required.')
      end

      expect(page).to have_content('Please fill in all required fields')
    end

    scenario 'should see prefilled name and description' do
      client = create(:client)
      login_as client.user

      create(:project_price, project_type: :logo, price: 123.5)
      project = create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client, name: nil, description: nil)

      visit '/c/projects/new/details'

      expect(page).to have_field('project-name', with: project.brand_name)
      expect(page).to have_field('project-description', with: project.company_description)
    end

    scenario 'should see prefilled name and description (empty company description)' do
      client = create(:client)
      login_as client.user

      create(:project_price, project_type: :logo, price: 123.5)
      project = create(
        :project,
        state: Project::STATE_WAITING_FOR_DETAILS,
        client: client,
        company_description: '',
        description: nil,
        name: nil
      )

      visit '/c/projects/new/details'

      expect(page).to have_field('project-name', with: project.brand_name)
      expect(page).to have_field('project-description', with: project.background_story)
    end
  end
end
