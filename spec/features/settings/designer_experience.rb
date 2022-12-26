# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'Designer can edit his experience', js: true do
  scenario 'Designer edits his experience and portfolio' do
    user = create(:designer).user

    login_as(user)
    visit '/d/settings/experience'
    expect(page).to have_selector('.settings__wrap')
    dropdown_select '4-7 years', from: 'exp-brand-identity'
    4.times { |i| attach_portfolio_work(container: "#brandIdentity_#{i}_container") }
    dropdown_select '4-7 years', from: 'exp-packaging'
    4.times { |i| attach_portfolio_work(container: "#packaging_#{i}_container") }
    dropdown_select 'Good', from: 'exp-english'
    click_button 'Submit'
    click_link 'Password'
    click_link 'Experience'

    selector = find('select[name="forms.designerSettingsExperience.experienceBrand"]', visible: false)
    expect(selector.value).to eq('middle_brand_experience')
    selector = find('select[name="forms.designerSettingsExperience.experiencePackaging"]', visible: false)
    expect(selector.value).to eq('middle_packaging_experience')
    selector = find('select[name="forms.designerSettingsExperience.experienceEnglish"]', visible: false)
    expect(selector.value).to eq('good_english')
  end

  def attach_portfolio_work(container:)
    within container do
      execute_script %|document.querySelector('#{container} input[type="file"]').id = '#{container}_file';|
      execute_script %|document.querySelector('#{container} input[type="file"]').style.display = 'block';|
      attach_file("#{container}_file", Rails.root.join('spec/factories/files/test.png'))
      find('.main-input__input').set('description')
      find('.main-input__input').native.send_keys(:Enter)
    end
  end
end
