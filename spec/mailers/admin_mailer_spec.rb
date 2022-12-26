# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminMailer do
  subject { described_class }
  let(:database_dump_id) { 1 }
  let(:admin_email) { Faker::Internet.email }

  describe 'database_dump_done' do
    let(:mail) { subject.database_dump_done(database_dump_id: database_dump_id, admin_email: admin_email).deliver }

    it do
      expect(mail.to).to match_array(admin_email)
      expect(mail.from).to match_array(['chris@designbro.com'])
      expect(mail.subject).to eq(I18n.t('admin_mailer.database_dump.done'))
      expect(mail.body.encoded).to match(/Database dumping successfully completed./)
      expect(mail.body.encoded).to match(/Go to admin panel/)
    end
  end

  describe 'database_dump_failed' do
    let(:mail) { subject.database_dump_failed(admin_email: admin_email).deliver }

    it do
      expect(mail.to).to match_array(admin_email)
      expect(mail.from).to match_array(['chris@designbro.com'])
      expect(mail.subject).to eq(I18n.t('admin_mailer.database_dump.failed'))
      expect(mail.body.encoded).to match(/Database dump was failed/)
    end
  end
end
