# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer can create payout', js: true do
  scenario 'Designer creates payout with valid data', skip: true do
    credentials = { email: 'example@gmail.com', password: 'pass1234' }
    user        = create(:user, credentials)
    designer    = create(:designer, user: user)

    create(:payout_min_amount)
    create(:united_kingdom_vat_rate)
    create(:earning, designer: designer)

    login_as(user)
    visit '/d/my-earnings'
    click_on 'Request Payout'
    expect(page).to have_selector('.main-modal')

    fill_in 'country', with: 'United Kingdom'
    find('li', exact_text: 'United Kingdom').click
    js_click '#bank-transfer'
    fill_in 'bank-acc-number', with: Faker::Number.number(10)
    fill_in 'swift-bic-code', with: Faker::Number.number(10)

    fill_in 'first-name', with: Faker::Name.first_name
    fill_in 'last-name', with: Faker::Name.last_name
    fill_in 'address1', with: Faker::Address.street_address
    fill_in 'city', with: Faker::Address.city
    fill_in 'number', with: Faker::PhoneNumber.phone_number
    click_button 'Send Request'

    expect(page).to have_content('AVAILABLE FOR PAYOUT $ 0')
  end

  scenario 'Designer creates payout with invalid data' do
    user     = create(:user)
    designer = create(:designer, user: user)

    create(:payout_min_amount)
    create(:earning, designer: designer)

    login_as(user)
    visit '/d/my-earnings'

    find('#request-payout').click
    fill_in 'country', with: 'Albania'
    find('li', exact_text: 'Albania').click

    find('#paypal').click
    click_button 'Send Request'

    expect(page).to have_content('Required')
  end
end
