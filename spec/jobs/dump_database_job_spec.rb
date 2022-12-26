# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DumpDatabaseJob do
  describe '#perform' do
    let(:double_database_dump) { double('DatabaseDump', id: 1) }
    let(:subject_double) { double('Databases::CreateDump', call: true, database_dump: double_database_dump) }
    let(:admin_user) { create(:user) }
    let(:admin_user_id) { admin_user.id }

    before do
      allow(AdminUser).to receive(:find_by).with(id: admin_user_id) { admin_user }
    end

    it 'calls AbandonedCarts::RemindersSender' do
      allow(subject_double).to receive(:success?) { true }
      expect(Databases::CreateDump).to receive(:new) { subject_double }
      expect(AdminMailer).to receive(:database_dump_done)
        .with(admin_email: admin_user.email, database_dump_id: double_database_dump.id)
        .and_return(double('Mailer', deliver_later: true))
      subject.perform(admin_user_id)
    end

    it 'calls AbandonedCarts::RemindersSender' do
      allow(subject_double).to receive(:success?) { false }
      expect_any_instance_of(Databases::CreateDump).to receive(:call) { subject_double }
      expect(AdminMailer).to receive(:database_dump_failed)
        .with(admin_email: admin_user.email)
        .and_return(double('Mailer', deliver_later: true))
      subject.perform(admin_user_id)
    end
  end
end
