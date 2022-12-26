# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiptsHelper do
  include ReceiptsHelper

  describe '#nda_free?' do
    subject { nda_free?(nda) }

    describe 'free' do
      let(:nda) { create(:free_nda) }
      it { is_expected.to be_truthy }
    end

    describe 'standard' do
      let(:nda) { create(:standard_nda) }
      it { is_expected.to be_falsey }
    end

    describe 'custom' do
      let(:nda) { create(:custom_nda) }
      it { is_expected.to be_falsey }
    end
  end

  describe '#vat_percent' do
    subject { vat_percent(project) }

    describe 'european country' do
      describe 'vat number not empty' do
        before(:each)         { create(:united_kingdom_vat_rate) }

        let(:billing_address) { create(:eu_billing_address) }
        let(:project)         { billing_address.project }

        it { is_expected.to eq(0) }
      end

      describe 'vat number empty' do
        before(:each)         { create(:united_kingdom_vat_rate) }

        let(:billing_address) { create(:eu_billing_address, vat: '') }
        let(:project)         { billing_address.project }

        it { is_expected.to eq(25) }
      end
    end

    describe 'non european country' do
      let(:billing_address) { create(:billing_address) }
      let(:project)         { billing_address.project }

      it { is_expected.to eq(0) }
    end
  end

  describe '#project_type_name' do
    [:logo, :brand_identity, :packaging].each do |project_type|
      context project_type do
        before { @project = create(:project, project_type: project_type) }
        it { expect(project_type_name).to eq(I18n.t("project_name.#{project_type}")) }
      end
    end

    context 'upgraded logo' do
      before { @project = create(:brand_identity_project, upgrade_package: true) }
      it { expect(project_type_name).to eq(I18n.t('project_name.logo')) }
    end
  end

  describe '#project_type_price' do
    let!(:logo_project_price) { create(:logo_project_price, price: 190) }
    let!(:brand_identity_project_price) { create(:brand_identity_project_price, price: 200) }
    let!(:packaging_project_price) { create(:packaging_project_price) }

    context 'upgraded logo' do
      before { @project = create(:brand_identity_project, upgrade_package: true) }
      it { expect(project_type_price).to eq(logo_project_price.price) }
    end

    context 'not upgraded logo' do
      before { @project = create(:project) }
      it { expect(project_type_price).to eq(@project.project_type_price) }
    end
  end

  describe '#payment_type_name' do
    [:credit_card, :pay_pal, :bank_transfer].each do |payment_type|
      context payment_type do
        before { @payment = create(:payment, payment_type: payment_type) }
        it { expect(payment_type_name).to eq(I18n.t("paid_with.#{payment_type}")) }
      end
    end
  end

  describe '#upgrade_price' do
    let!(:logo_project_price) { create(:logo_project_price, price: 190) }
    let!(:brand_identity_project_price) { create(:brand_identity_project_price, price: 200) }

    it { expect(upgrade_price).to eq(brand_identity_project_price.price - logo_project_price.price) }
  end
end
