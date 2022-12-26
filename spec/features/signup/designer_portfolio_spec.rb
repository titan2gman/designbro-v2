# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer uploads portfolio', js: true do
  scenario 'fill in all brand identity portfolios' do
    designer = create(:designer,
                      portfolio_uploaded: false,
                      experience_brand: 'senior_brand_experience',
                      experience_packaging: 'senior_packaging_experience')

    login_as(designer.user)
    visit '/d/signup/step3'

    4.times do |i|
      within "#brandIdentity_#{i}_container" do
        execute_script %|document.querySelectorAll('input[type="file"]')[#{i}].id = 'attach_file_#{i}';|
        attach_file("attach_file_#{i}", Rails.root.join('spec/factories/files/test.png'), visible: false)
        expect(page).to have_selector('.file-uploaded', visible: false)
        fill_in 'comment', with: 'description'
      end
    end

    4.times do |i|
      within "#packaging_#{i}_container" do
        execute_script %|document.querySelectorAll('input[type="file"]')[#{i + 4}].id = 'attach_file_#{i + 4}';|
        attach_file("attach_file_#{i + 4}", Rails.root.join('spec/factories/files/test.png'), visible: false)
        expect(page).to have_selector('.file-uploaded', visible: false)
        fill_in 'comment', with: 'description'
      end
    end

    click_button 'Submit Portfolio'
    expect(page).not_to have_content('Required')
    expect(page).to have_selector('.main-modal')
    within('.main-modal') { find('#share-modal-submit').click }

    expect(page).to have_selector('.join-complete')
    expect(page).to have_content('Great, thank you!')
    expect(page).to have_selector('.no-open-modals', visible: false)
  end

  scenario 'and does not set any data' do
    designer = create(:designer,
                      portfolio_uploaded: false,
                      experience_brand: 'senior_brand_experience',
                      experience_packaging: 'senior_packaging_experience')

    login_as(designer.user)
    visit '/d/signup/step3'
    click_button 'Submit Portfolio'
    expect(page).to have_content('Required')
    expect(page).to have_selector('.no-open-modals', visible: false)
  end

  scenario 'and does not fill in any comment' do
    designer = create(:designer,
                      portfolio_uploaded: false,
                      experience_brand: 'senior_brand_experience',
                      experience_packaging: 'senior_packaging_experience')

    login_as(designer.user)
    visit '/d/signup/step3'

    4.times do |i|
      within "#brandIdentity_#{i}_container" do
        execute_script %|document.querySelectorAll('input[type="file"]')[#{i}].id = 'attach_file_#{i}';|
        attach_file("attach_file_#{i}", Rails.root.join('spec/factories/files/test.png'), visible: false)
        expect(page).to have_selector('.file-uploaded', visible: false)
      end
    end

    4.times do |i|
      within "#packaging_#{i}_container" do
        execute_script %|document.querySelectorAll('input[type="file"]')[#{i + 4}].id = 'attach_file_#{i + 4}';|
        attach_file("attach_file_#{i + 4}", Rails.root.join('spec/factories/files/test.png'), visible: false)
        expect(page).to have_selector('.file-uploaded', visible: false)
      end
    end

    click_button 'Submit Portfolio'
    expect(page).to have_content('Required', count: 8)
    expect(page).to have_selector('.no-open-modals', visible: false)
  end

  scenario 'and does not upload any portfolio' do
    designer = create(:designer,
                      portfolio_uploaded: false,
                      experience_brand: 'senior_brand_experience',
                      experience_packaging: 'senior_packaging_experience')

    login_as(designer.user)
    visit '/d/signup/step3'

    4.times do |i|
      within "#brandIdentity_#{i}_container" do
        fill_in 'comment', with: 'description'
      end
    end

    4.times do |i|
      within "#packaging_#{i}_container" do
        fill_in 'comment', with: 'description'
      end
    end

    click_button 'Submit Portfolio'
    expect(page).to have_content('Required')
    expect(page).to have_selector('.no-open-modals', visible: false)
  end
end
