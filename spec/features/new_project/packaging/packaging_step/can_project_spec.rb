# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Client can complete packaging step for can project', js: true do
  context 'authenticated user' do
    scenario 'chooses packaging type without measurements' do
      product = create(:product, key: 'packaging')
      project = create(:project, state: :draft, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/packaging"

      expect(page).to have_content('Tell us which of the following you would like to design on:')
      expect(page).to have_content('Please select which of the following best describes the type of pack that you would to use:')

      find('#can-packaging-type').click

      expect(page).to have_content('Can measurements')

      click_on 'Continue'
      expect(page).to have_content 'Please give us the size or upload technical drawing.'
    end

    scenario 'chooses packaging type with measurements' do
      product = create(:product, key: 'packaging')
      project = create(:project, state: :draft, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/packaging"

      expect(page).to have_content('Tell us which of the following you would like to design on:')
      expect(page).to have_content('Please select which of the following best describes the type of pack that you would to use:')

      find('#can-packaging-type').click

      expect(page).to have_content('Can measurements')

      ['height', 'diameter', 'volume'].each do |field|
        fill_in "can-#{field}", with: '1.5 cm'
      end

      click_on 'Continue'
      expect(page).to have_content 'Describe your brand DNA'

      project = Project.last
      expect(product.key).to eq 'packaging'
      expect(project.state).to eq 'waiting_for_style_details'

      measurements = project.packaging_measurements
      expect(measurements.packaging_type).to eq :can

      [:height, :diameter, :volume].each do |property|
        expect(measurements.public_send(property)).to eq('1.5 cm')
      end
    end

    scenario 'chooses packaging type via uploading technical drawing' do
      product = create(:product, key: 'packaging')
      project = create(:project, state: :draft, product: product)

      login_as(project.brand.company.clients.first.user)
      visit "/projects/#{project.id}/packaging"

      expect(page).to have_content('Tell us which of the following you would like to design on:')
      expect(page).to have_content('Please select which of the following best describes the type of pack that you would to use:')

      find('#can-packaging-type').click

      expect(page).to have_content('Can measurements')

      execute_script(%|document.querySelectorAll('input[type="file"]')[0].id = 'attach_file_0';|)
      attach_file('attach_file_0', Rails.root.join('spec/factories/files/test.png'), visible: false)

      expect(page).to have_selector('.file-uploaded', visible: false)

      click_on 'Continue'
      expect(page).to have_content 'Describe your brand DNA'

      project = Project.last
      expect(product.key).to eq 'packaging'
      expect(project.state).to eq 'waiting_for_style_details'

      measurements = project.packaging_measurements
      expect(measurements.packaging_type).to eq :can
      expect(measurements.technical_drawing).not_to be_nil
    end
  end
end
