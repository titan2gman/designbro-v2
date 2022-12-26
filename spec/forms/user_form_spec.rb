# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserForm do
  describe '#save' do
    it 'set mailchimp job' do
      user = create(:user, notify_news: false)
      form = UserForm.new(
        id: user.id,
        notify_news: true,
        notify_messages_received: true,
        notify_projects_updates: true,
        inform_on_email: ''
      )

      expect do
        form.save
      end.to have_enqueued_job
    end
  end
end
