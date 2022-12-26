# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectDetailsStepForm do
  describe '#save' do
    it 'successfully updates project in DB' do
      [:logo, :packaging, :brand_identity].each do |project_type|
        create(:"#{project_type}_project_price")
      end
      create(:custom_nda_price)

      project_attributes = attributes_for(:project).slice(
        :business_customer,
        :max_spots_count,
        :upgrade_package,
        :description,
        :name
      )

      attributes = {}
      attributes.merge! project_attributes

      attributes.merge!(
        nda_type: 'custom',
        nda_value: 'abc123',
        discount_code: create(:dollar_discount, value: 200).code
      )

      project = create(:project, state: Project::STATE_WAITING_FOR_DETAILS)

      form = described_class.new(
        attributes.merge(id: project.id, upgrade_project_state: true)
      )

      expect(form).to be_valid
      expect(form.save).to be_truthy

      project = project.reload

      expect(project.discount_amount_cents).not_to be_zero
      expect(project.designer_discount_amount_cents).not_to be_zero
      expect(project.price).not_to be_nil
      expect(project.nda.value).to eq 'abc123'
      expect(project.nda.nda_type).to eq 'custom'
      expect(project.state).to eq Project::STATE_WAITING_FOR_CHECKOUT.to_s

      [:name, :description, :upgrade_package, :business_customer].each do |property|
        expect(project.public_send(property)).to eq attributes[property]
      end

      nda = project.nda

      expect(nda).not_to be_nil
      expect(nda).to be_persisted
      expect(nda.value).to eq attributes[:nda_value]
      expect(nda.nda_type).to eq attributes[:nda_type]
    end
  end

  describe 'price calculation' do
    it 'logo design' do
      project_price = create(:logo_project_price, price: 500)
      create(:custom_nda_price)
      discount = create(:discount, discount_type: :percent, value: 10)

      attributes = attributes_for(:project).slice(
        :max_spots_count,
        :description,
        :name
      )

      project = create(:logo_project)

      attributes.merge!(
        upgrade_project_state: true,
        business_customer: false,
        upgrade_package: false,
        discount_code: discount.code,
        nda_value: 'abc123',
        nda_type: 'custom',
        id: project.id
      )

      form = described_class.new attributes

      expect(form).to be_valid
      expect(form.save).to be_truthy

      project = form.project
      custom_nda_price = create(:custom_nda).price.to_f

      expect(project.discount_amount_cents).to eq((project_price.price + custom_nda_price) * discount.value)
      expect(project.designer_discount_amount_cents).to eq project_price.price * discount.value
      expect(project.price).to eq(project_price.price + custom_nda_price - project.discount_amount.to_f)
    end

    it 'packaging design' do
      project_price = create(:packaging_project_price, price: 700)
      create(:custom_nda_price)
      discount = create(:discount, discount_type: :percent, value: 10)

      attributes = attributes_for(:project).slice(
        :max_spots_count,
        :description,
        :name
      )

      project = create(:packaging_project)

      attributes.merge!(attributes.merge!(
                          business_customer: true,
                          upgrade_package: false,
                          upgrade_project_state: true,
                          discount_code: discount.code,
                          nda_value: 'abc123',
                          nda_type: 'custom',
                          country_code: 'GB',
                          id: project.id
                        ))

      form = described_class.new attributes

      expect(form).to be_valid
      expect(form.save).to be_truthy

      project = form.project
      custom_nda_price = create(:custom_nda).price.to_f

      expect(project.discount_amount_cents).to eq((project_price.price + custom_nda_price) * discount.value)
      expect(project.designer_discount_amount_cents).to eq project_price.price * discount.value
      expect(project.price).to eq(project_price.price + custom_nda_price - project.discount_amount.to_f)
    end

    it 'brand identity design' do
      project_price = create(:brand_identity_project_price, price: 900)
      create(:custom_nda_price)
      discount = create(:discount, discount_type: :percent, value: 10)

      attributes = attributes_for(:project).slice(
        :max_spots_count,
        :description,
        :name
      )

      project = create(:brand_identity_project)

      attributes.merge!(
        business_customer: true,
        upgrade_package: false,
        upgrade_project_state: true,
        discount_code: discount.code,
        nda_value: 'abc123',
        nda_type: 'custom',
        country_code: 'GB',
        id: project.id
      )

      form = described_class.new attributes

      expect(form).to be_valid
      expect(form.save).to be_truthy

      project = form.project
      custom_nda_price = create(:custom_nda).price.to_f

      expect(project.discount_amount_cents).to eq((project_price.price + custom_nda_price) * discount.value)
      expect(project.designer_discount_amount_cents).to eq project_price.price * discount.value
      expect(project.price).to eq(project_price.price + custom_nda_price - project.discount_amount.to_f)
    end
  end

  describe 'validations', type: :model do
    subject { described_class.new(upgrade_project_state: true) }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :nda_type }
    it { is_expected.to validate_presence_of :description }

    it { is_expected.to validate_inclusion_of(:nda_type).in_array ['standard', 'custom', 'free'] }

    it { is_expected.to validate_numericality_of(:max_spots_count).is_greater_than_or_equal_to(3).is_less_than_or_equal_to(10) }

    describe 'validate text of the NDA if NDA type is custom' do
      subject { described_class.new(nda_type: :custom, upgrade_project_state: true) }
      it { is_expected.to validate_presence_of :nda_value }
    end

    describe 'do not validate text of the NDA if NDA type is standard' do
      subject { described_class.new(nda_type: :standard, upgrade_project_state: true) }
      it { is_expected.not_to validate_presence_of :nda_value }
    end

    describe 'do not validate text of the NDA if NDA type is free' do
      subject { described_class.new(nda_type: :free, upgrade_project_state: true) }
      it { is_expected.not_to validate_presence_of :nda_value }
    end

    it 'should be valid if country code is real' do
      form = described_class.new(country: 'Ukraine', country_code: 'UA', upgrade_project_state: true)
      expect(form.errors.messages[:country_code]).to be_empty
    end

    it 'should be invalid if user tries to upgrade packaging project' do
      project = create(:packaging_project)

      form = described_class.new(
        id: project.id,
        upgrade_package: true,
        upgrade_project_state: true
      )

      expect(form).not_to be_valid

      error = I18n.t 'errors.messages.can_upgrade_only_logo_project'
      expect(form.errors.messages[:upgrade_package]).to include(error)
    end

    it 'should be invalid if user tries to upgrade brand identity project' do
      project = create(:brand_identity_project)

      form = described_class.new(
        id: project.id,
        upgrade_package: true,
        upgrade_project_state: true
      )

      expect(form).not_to be_valid

      error = I18n.t 'errors.messages.can_upgrade_only_logo_project'
      expect(form.errors.messages[:upgrade_package]).to include(error)
    end
  end
end
