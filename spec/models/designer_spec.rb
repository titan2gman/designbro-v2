# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Designer do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:portfolio_works) }

    it { is_expected.to have_many(:spots).dependent(:destroy) }
    it { is_expected.to have_many(:designs).dependent(:destroy).through(:spots) }
    it { is_expected.to have_many(:reviews)                    .through(:designs) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    it { is_expected.to validate_presence_of(:country_code) }

    it { is_expected.to validate_presence_of(:age) }
    it { is_expected.to validate_presence_of(:gender) }

    it { is_expected.to validate_presence_of(:experience_brand) }
    it { is_expected.to validate_presence_of(:experience_english) }
    it { is_expected.to validate_presence_of(:experience_packaging) }

    describe 'display_name' do
      it { is_expected.to validate_presence_of(:display_name) }
      it { is_expected.to validate_uniqueness_of(:display_name) }
      it { is_expected.to allow_value('name').for(:display_name) }

      context 'on create' do
        ['display.name', 'display@name'].each do |display_name|
          it { is_expected.not_to allow_value(display_name).for(:display_name).on(:create) }
        end
      end

      context 'on update' do
        context 'had . or @ before' do
          let(:designer) do
            create(:designer).tap do |record|
              record.update_attribute(:display_name, 'display.name')
            end
          end

          ['display.name', 'display@name'].each do |value|
            it { expect(designer).to allow_value(value).for(:display_name).on(:update) }
          end
        end

        context 'did not have . and @ before' do
          let(:designer) { create(:designer, display_name: 'display_name') }

          ['display.name', 'display@name'].each do |value|
            it { expect(designer).not_to allow_value(value).for(:display_name).on(:update) }
          end
        end
      end
    end
  end

  describe '#brand_identity_state' do
    it { is_expected.to transition_from(:draft).to(:pending).on_event(:brand_identity_upload_works).on(:brand_identity_state) }
    it { is_expected.to transition_from(:disapproved).to(:pending).on_event(:brand_identity_upload_works).on(:brand_identity_state) }
    it { is_expected.to transition_from(:pending).to(:approved).on_event(:brand_identity_approve).on(:brand_identity_state) }

    it { is_expected.to transition_from(:pending).to(:disapproved).on_event(:brand_identity_disapprove).on(:brand_identity_state) }
    it { is_expected.to transition_from(:approved).to(:disapproved).on_event(:brand_identity_disapprove).on(:brand_identity_state) }
  end

  describe '#packaging_state' do
    it { is_expected.to transition_from(:draft).to(:pending).on_event(:packaging_upload_works).on(:packaging_state) }
    it { is_expected.to transition_from(:disapproved).to(:pending).on_event(:packaging_upload_works).on(:packaging_state) }
    it { is_expected.to transition_from(:pending).to(:approved).on_event(:packaging_approve).on(:packaging_state) }

    it { is_expected.to transition_from(:pending).to(:disapproved).on_event(:packaging_disapprove).on(:packaging_state) }
    it { is_expected.to transition_from(:approved).to(:disapproved).on_event(:packaging_disapprove).on(:packaging_state) }
  end

  describe '#count_of_approved_states' do
    subject { create(:designer, brand_identity_state: brand_identity_state, packaging_state: packaging_state) }

    context 'brand_identity approved' do
      let(:brand_identity_state) { Designer::STATE_BRAND_IDENTITY_APPROVED }

      context 'packaging approved' do
        let(:packaging_state) { Designer::STATE_PACKAGING_APPROVED }

        it { expect(subject.count_of_approved_states).to eq(2) }
        it { expect(subject.count_of_disapproved_states).to eq(0) }
      end

      context 'packaging disapproved' do
        let(:packaging_state) { Designer::STATE_PACKAGING_DISAPPROVED }

        it { expect(subject.count_of_approved_states).to eq(1) }
        it { expect(subject.count_of_disapproved_states).to eq(1) }
      end
    end

    context 'brand_identity disapproved' do
      let(:brand_identity_state) { Designer::STATE_BRAND_IDENTITY_DISAPPROVED }

      context 'packaging approved' do
        let(:packaging_state) { Designer::STATE_PACKAGING_APPROVED }

        it { expect(subject.count_of_approved_states).to eq(1) }
        it { expect(subject.count_of_disapproved_states).to eq(1) }
      end

      context 'packaging disapproved' do
        let(:packaging_state) { Designer::STATE_PACKAGING_DISAPPROVED }

        it { expect(subject.count_of_approved_states).to eq(0) }
        it { expect(subject.count_of_disapproved_states).to eq(2) }
      end
    end
  end

  describe '#approved_project_types' do
    subject { create(:designer, brand_identity_state: brand_identity_state, packaging_state: packaging_state) }

    context 'brand_identity and packaging approved' do
      let(:brand_identity_state) { Designer::STATE_BRAND_IDENTITY_APPROVED }
      let(:packaging_state) { Designer::STATE_PACKAGING_APPROVED }

      it { expect(subject.approved_project_types).to eq([0, 1, 2]) }
    end

    context 'brand_identity and packaging disapproved' do
      let(:brand_identity_state) { Designer::STATE_BRAND_IDENTITY_DISAPPROVED }
      let(:packaging_state) { Designer::STATE_PACKAGING_DISAPPROVED }

      it { expect(subject.approved_project_types).to eq([]) }
    end
  end
end
