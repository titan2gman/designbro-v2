# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailchimpJob do
  describe '#perform_later' do
    it 'creates job' do
      user = create(:user)

      expect { MailchimpJob.perform_later(user, true) }
        .to have_enqueued_job(MailchimpJob).with(user, true)

      expect(MailchimpJob).to have_been_enqueued.exactly(:once)
    end
  end
end
