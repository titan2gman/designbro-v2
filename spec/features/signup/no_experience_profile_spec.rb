# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer cannot signup without experience', js: true do
  scenario 'Designer is bad at english' do
    user = create(:user)
    designer = user.build_designer(display_name: 'Display')
    designer.save(validate: false)

    login_as(user)
    visit '/d/signup/step2'
    expect(page).to have_content('Welcome to DesignBro!')

    designer_attrs = attributes_for(:designer)
    fill_in :first_name, with: designer_attrs[:first_name]
    fill_in :last_name, with: designer_attrs[:last_name]
    fill_in :country, with: 'Ukraine'
    fill_in :age, with: designer_attrs[:age]
    dropdown_select 'Female', from: :gender
    dropdown_select '1-3 years', from: :experienceBrand
    dropdown_select 'No experience', from: :experiencePackaging
    dropdown_select 'Not good', from: :experienceEnglish
    click_button 'Next Step'

    expect(page).to have_selector('.main-modal')
    expect(page).to have_content('Sorry DesignBro is currently only available for designers who read & write in English. Feel free to check back later.')
  end

  scenario 'Designer is bad at design' do
    user = create(:user)
    designer = user.build_designer(display_name: 'Display')
    designer.save(validate: false)

    login_as(user)
    visit '/d/signup/step2'
    expect(page).to have_content('Welcome to DesignBro!')

    designer_attrs = attributes_for(:designer)
    fill_in :first_name, with: designer_attrs[:first_name]
    fill_in :last_name, with: designer_attrs[:last_name]
    fill_in :country, with: 'Ukraine'
    fill_in :age, with: designer_attrs[:age]
    dropdown_select 'Female', from: :gender
    dropdown_select 'No experience', from: :experienceBrand
    dropdown_select 'No experience', from: :experiencePackaging
    dropdown_select 'Acceptable', from: :experienceEnglish
    click_button 'Next Step'
    expect(page).to have_selector('.main-modal')
    expect(page).to have_content("You mentioned you have 'no experience'. That means that you will not be able to use our platform, as we currently only offer our clients experienced designers. You can come back if you made a mistake or once you have a bit more experience.")
  end
end
