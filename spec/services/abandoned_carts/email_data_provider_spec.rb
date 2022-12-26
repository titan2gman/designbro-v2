# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AbandonedCarts::EmailDataProvider do
  subject { described_class.new(project, remidner_step) }

  let(:project) { create(:project, project_type: project_type) }
  let(:project_type) { :logo }
  let(:remidner_step) { 'first_reminder' }

  describe '#subject' do
    let(:discount) { create(:discount, discount_type: :percent, value: 10) }
    let(:abandoned_cart_discount) { create(:abandoned_cart_discount, discount: discount) }

    describe 'first_reminder' do
      it 'returns subject for email' do
        abandoned_cart_discount
        expect(subject.email_subject).to eq "You’re almost there! Get 10% off Today for your #{project.brand_name} design"
      end
    end

    describe 'second_reminder' do
      let(:remidner_step) { 'second_reminder' }

      it 'returns subject for email' do
        abandoned_cart_discount
        expect(subject.email_subject).to eq "Last Chance! Get 10% off the next hour for your #{project.brand_name} design"
      end
    end

    describe 'third_reminder' do
      let(:remidner_step) { 'third_reminder' }

      it 'returns subject for email' do
        expect(subject.email_subject).to eq "Your design project for #{project.brand_name} is waiting to get started..."
      end
    end
  end

  describe '#continue_brief_url' do
    let(:url) { 'http://continue_brief_url.com' }

    it 'returns continue brief url' do
      expect_any_instance_of(Deeplinks::ProjectBrief::Generate).to receive(:call)
        .and_return(url)
      expect(subject.continue_brief_url).to eq url
    end
  end

  describe '#unsubscribe_url' do
    let(:url) { 'http://unsubscribe_url.com' }

    it 'returns continue brief url' do
      allow_any_instance_of(Emails::AbandonedCarts::GenerateUnsubscribeUrl).to receive(:call)
        .and_return(url)
      expect(subject.unsubscribe_url).to eq url
    end
  end

  describe '#tip_and_tricks_url' do
    describe 'logo' do
      it 'returns https://designbro.com/how-to-get-your-logo/' do
        expect(subject.tip_and_tricks_url).to eq 'https://designbro.com/how-to-get-your-logo/'
      end
    end

    describe 'brand_identity' do
      let(:project_type) { :brand_identity }

      it 'returns https://designbro.com/how-to-get-your-brand-identity/' do
        expect(subject.tip_and_tricks_url).to eq 'https://designbro.com/how-to-get-your-brand-identity/'
      end
    end
    describe 'packaging' do
      let(:project_type) { :packaging }

      it 'returns https://designbro.com/how-to-get-your-packaging-design/' do
        expect(subject.tip_and_tricks_url).to eq 'https://designbro.com/how-to-get-your-packaging-design/'
      end
    end
  end

  describe '#voucher_code' do
    let(:abandoned_cart_discount) { create(:abandoned_cart_discount) }
    it 'returns voucher code' do
      abandoned_cart_discount
      expect(subject.voucher_code).to eq abandoned_cart_discount.discount.code
    end
  end

  describe '#discount_amount_title' do
    let(:abandoned_cart_discount) { create(:abandoned_cart_discount, discount: discount) }

    describe 'percent discount' do
      let(:discount) { create(:discount, discount_type: :percent, value: 10) }

      it do
        abandoned_cart_discount
        expect(subject.discount_amount_title).to eq "#{discount.value}%"
      end
    end

    describe 'dollar discount' do
      let(:discount) { create(:discount, discount_type: :dollar, value: 10) }
      it do
        abandoned_cart_discount
        expect(subject.discount_amount_title).to eq "#{discount.value}$"
      end
    end
  end
end
