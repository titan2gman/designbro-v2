# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectStationeryStepForm do
  describe '#save' do
    it "successfully saves project (state: #{Project::STATE_WAITING_FOR_STATIONERY_DETAILS})" do
      attributes = attributes_for(:project).slice(
        :front_business_card_details,
        :back_business_card_details,
        :letter_head,
        :compliment
      )

      project = create(:brand_identity_project, state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS)
      create(:credit_card_payment, project: project)

      form = ProjectStationeryStepForm.new(
        attributes.merge(id: project.id, upgrade_project_state: true)
      )

      expect(form).to be_valid
      expect(form.save).to be_truthy

      attributes.each do |field_name, expected_value|
        expect(form.project.public_send(field_name)).to eq(expected_value)
      end

      expect(form.project.state).to eq Project::STATE_DESIGN_STAGE.to_s
    end

    it "successfully saves project (state: #{Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS}\
        and payment_type: brand_transfer)" do
      attributes = attributes_for(:project).slice(
        :front_business_card_details,
        :back_business_card_details,
        :letter_head,
        :compliment
      )

      project = create(:brand_identity_project, state: Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS)
      create(:bank_transfer_payment, project: project)

      form = ProjectStationeryStepForm.new(
        attributes.merge(id: project.id, upgrade_project_state: true)
      )

      expect(form).to be_valid
      expect(form.save).to be_truthy

      attributes.each do |field_name, expected_value|
        expect(form.project.public_send(field_name)).to eq(expected_value)
      end

      expect(form.project.state).to eq Project::STATE_WAITING_FOR_PAYMENT.to_s
    end
  end

  context 'validations', type: :model do
    subject { ProjectStationeryStepForm.new(upgrade_project_state: true) }

    it { expect(ProjectStationeryStepForm.new).to validate_presence_of :id }

    [:compliment, :letter_head].each do |field|
      it { is_expected.to validate_presence_of field }
    end

    [:back_business_card_details, :front_business_card_details].each do |field|
      it { is_expected.to validate_presence_of field }
    end

    describe 'project type' do
      let(:project) { create(:project, state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS, project_type: type) }

      subject do
        attributes = attributes_for(:project).slice(
          :front_business_card_details,
          :back_business_card_details,
          :letter_head, :compliment
        )

        form = ProjectStationeryStepForm.new(
          attributes.merge(id: project.id, upgrade_project_state: true)
        )

        form.valid?

        form.errors.messages[:project]
      end

      describe 'brand_identity' do
        let(:type) { :brand_identity }
        it { is_expected.to be_empty }
      end

      describe 'packaging' do
        let(:type) { :packaging }
        it { is_expected.not_to be_empty }
      end

      describe 'logo' do
        let(:type) { :logo }
        it { is_expected.not_to be_empty }
      end
    end

    describe 'project state' do
      let(:project) { create(:project, project_type: :brand_identity, state: state) }

      subject do
        attributes = attributes_for(:project).slice(
          :front_business_card_details,
          :back_business_card_details,
          :letter_head, :compliment
        )

        form = ProjectStationeryStepForm.new(
          attributes.merge(id: project.id, upgrade_project_state: true)
        )

        form.valid?

        form.errors.messages[:project]
      end

      [
        Project::STATE_WAITING_FOR_DETAILS,
        Project::STATE_WAITING_FOR_CHECKOUT,
        Project::STATE_WAITING_FOR_PAYMENT
      ].each do |state|
        describe state do
          let(:state) { state }
          it { is_expected.not_to be_empty }
        end
      end

      describe Project::STATE_WAITING_FOR_STATIONERY_DETAILS do
        let(:state) { :waiting_for_stationery_details }
        it { is_expected.to be_empty }
      end
    end
  end
end
