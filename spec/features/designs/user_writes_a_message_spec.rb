# frozen_string_literal: true

require 'feature_helper'

RSpec.feature 'User writes a chat message', js: true do
  scenario 'Designer writes a chat message' do
    skip 'actioncable doesnt work in feature tests'
    designer = create(:designer)
    project = create(:project)
    project.designers << designer
    design = create(:design, project: project, designer: designer)

    login_as(designer.user)
    visit "/d/projects/#{project.id}/designs/#{design.id}"

    within '.conv-leave-message-textarea' do
      find('.main-input__input').set('My message')
    end
    find('#direct-conversation-chat-submit').click

    within '.conv-dialog-item' do
      expect(page).to have_content('My message')
    end
  end
end
