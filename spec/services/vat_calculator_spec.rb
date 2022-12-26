# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VatCalculator do
  before(:all) do
    { logo: 499, packaging: 499, brand_identity: 699 }.each do |type, price|
      create(:"#{type}_project_price", price: price)
    end

    { GB: 20, IE: 23 }.each do |country_code, percent|
      VatRate.create country_name: 'Country name',
                     country_code: country_code,
                     percent: percent
    end
  end

  VAT_PRICES = {
    logo: {
      standard: {
        without_discount: 104.8,
        with_discount: 84.8
      },
      custom: {
        without_discount: 119.4,
        with_discount: 99.4
      },
      free: {
        without_discount: 99.8,
        with_discount: 79.8
      }
    },
    packaging: {
      standard: {
        without_discount: 104.8,
        with_discount: 84.8
      },
      custom: {
        without_discount: 119.4,
        with_discount: 99.4
      },
      free: {
        without_discount: 99.8,
        with_discount: 79.8
      }
    },
    brand_identity: {
      standard: {
        without_discount: 144.8,
        with_discount: 124.8
      },
      custom: {
        without_discount: 159.4,
        with_discount: 139.4
      },
      free: {
        without_discount: 139.8,
        with_discount: 119.8
      }
    }
  }.freeze

  describe '#call' do
    subject { VatCalculator.new(project).call }

    let(:project) do
      create(:project,
             billing_address: billing_address,
             business_customer: business_customer)
    end

    describe 'european country' do
      describe 'any except ireland' do
        let(:billing_address) { build(:eu_billing_address, vat: vat) }

        describe 'with VAT number' do
          let(:vat) { '12345678' }

          describe 'business customer' do
            let(:business_customer) { true }
            it { is_expected.to eq 0 }
          end

          describe 'non-business customer' do
            let(:business_customer) { false }

            it { is_expected.to be_a(BigDecimal) }
            it { is_expected.not_to be_nil }
            it { is_expected.not_to eq 0 }
          end
        end

        describe 'without VAT number' do
          let(:vat) { nil }

          describe 'business customer' do
            let(:business_customer) { true }

            it { is_expected.to be_a(BigDecimal) }
            it { is_expected.not_to be_nil }
            it { is_expected.not_to eq 0 }
          end

          describe 'non-business customer' do
            let(:business_customer) { false }

            it { is_expected.to be_a(BigDecimal) }
            it { is_expected.not_to be_nil }
            it { is_expected.not_to eq 0 }
          end
        end
      end

      describe 'ireland' do
        let(:billing_address) { build(:ireland_billing_address, vat: vat) }

        describe 'with VAT number' do
          let(:vat) { '12345678' }

          describe 'business customer' do
            let(:business_customer) { true }

            it { is_expected.to be_a(BigDecimal) }
            it { is_expected.not_to be_nil }
            it { is_expected.not_to eq 0 }
          end

          describe 'non-business customer' do
            let(:business_customer) { false }

            it { is_expected.to be_a(BigDecimal) }
            it { is_expected.not_to be_nil }
            it { is_expected.not_to eq 0 }
          end
        end

        describe 'without VAT number' do
          let(:vat) { '' }

          describe 'business customer' do
            let(:business_customer) { true }

            it { is_expected.to be_a(BigDecimal) }
            it { is_expected.not_to be_nil }
            it { is_expected.not_to eq 0 }
          end

          describe 'non-business customer' do
            let(:business_customer) { false }

            it { is_expected.to be_a(BigDecimal) }
            it { is_expected.not_to be_nil }
            it { is_expected.not_to eq 0 }
          end
        end
      end
    end

    describe 'non-european country' do
      let(:billing_address) { build(:non_eu_billing_address) }

      describe 'business customer' do
        let(:business_customer) { true }
        it { is_expected.to eq 0 }
      end

      describe 'non-business customer' do
        let(:business_customer) { false }
        it { is_expected.to eq 0 }
      end
    end

    describe 'answer' do
      let(:vat) { '12345678' }
      let(:business_customer) { false }
      let(:billing_address) { build(:eu_billing_address, vat: vat) }

      VAT_PRICES.each do |project_type, nda_type_prices|
        nda_type_prices.each do |nda_type, discount|
          discount.each do |discount_existence, price|
            it "expected to be #{price} for #{nda_type} nda type, #{project_type} type and #{discount_existence}" do
              nda = create(:"#{nda_type}_nda")
              discount_amount = discount_existence == :with_discount ? 100 : 0

              project = create(:project_without_nda,
                               business_customer: business_customer,
                               billing_address: billing_address,
                               discount_amount: discount_amount,
                               project_type: project_type,
                               nda: nda)

              value = VatCalculator.new(project).call

              expect(value.to_f).to eq(price)
              expect(value).to be_a(BigDecimal)
            end
          end
        end
      end
    end
  end
end
