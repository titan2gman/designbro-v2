# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AbandonedCartMailer do
  let(:project_type) { :logo }
  let(:reminder_step) { 'first_reminder' }
  let(:project) { create(:project, project_type: project_type) }
  let(:user) { project.client.user }
  let(:mail) { described_class.abandoned_cart_second_reminder(project: project).deliver }
  let(:discount) { create(:discount, discount_type: :dollar, value: 32) }
  let(:abandoned_cart_discount) { create(:abandoned_cart_discount, discount: discount) }

  before do
    abandoned_cart_discount
  end

  describe '#abandoned_cart_first_reminder' do
    let(:mail) { described_class.abandoned_cart_first_reminder(project: project, reminder_step: reminder_step).deliver }

    it do
      expect(mail.to).to match_array([user.email])
      expect(mail.from).to match_array(['chris@designbro.com'])
      expect(mail.subject).to eq("You’re almost there! Get 32$ off Today for your #{project.brand_name} design")
      expect(mail.body.encoded).to match(/Voucher: #{abandoned_cart_discount.discount.code}/)
    end
  end

  describe '#abandoned_cart_second_reminder' do
    let(:mail) { described_class.abandoned_cart_second_reminder(project: project, reminder_step: reminder_step).deliver }
    let(:reminder_step) { 'second_reminder' }

    it do
      expect(mail.to).to match_array([user.email])
      expect(mail.from).to match_array(['chris@designbro.com'])
      expect(mail.subject).to eq("Last Chance! Get 32$ off the next hour for your #{project.brand_name} design")
      expect(mail.body.encoded).to match(/Voucher: #{abandoned_cart_discount.discount.code}/)
    end
  end

  describe '#abandoned_cart_third_reminder' do
    let(:mail) { described_class.abandoned_cart_third_reminder(project: project, reminder_step: reminder_step).deliver }
    let(:reminder_step) { 'third_reminder' }

    it do
      expect(mail.to).to match_array([user.email])
      expect(mail.from).to match_array(['chris@designbro.com'])
      expect(mail.subject).to eq("Your design project for #{project.brand_name} is waiting to get started...")
      expect(mail.body.encoded).not_to match(/Voucher: #{abandoned_cart_discount.discount.code}/)
    end
  end
end
