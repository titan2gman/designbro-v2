# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'User can edit his notifications', js: true do
  scenario 'User edits his notifications' do
    user = create(:client).user

    login_as(user)
    visit '/c/settings/notifications'
    expect(page).to have_selector('.settings__wrap')

    find('#projects-updates').set(true)
    find('#messages-received').set(true)

    click_button 'Save Changes'
    expect(page).to have_selector('.modal-primary')

    user.reload

    expect(user.notify_projects_updates).to eq(true)
    expect(user.notify_messages_received).to eq(true)
  end
end
