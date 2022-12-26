# frozen_string_literal: true

require 'rails_helper'

PROJECT_STATES = Project.aasm.states.map(&:name).map(&:to_s)

AVAILABLE_RESERVE_STATES = [
  Project::STATE_DESIGN_STAGE
].map(&:to_s)

NOT_AVAILABLE_RESERVE_STATES = PROJECT_STATES - AVAILABLE_RESERVE_STATES

RSpec.describe Project do
  it_should_behave_like 'project money methods'
  it_should_behave_like 'project expire methods'

  describe 'associations' do
    it { is_expected.to belong_to(:client).optional }
    it { is_expected.to belong_to(:discount).optional }
    it { is_expected.to have_many :designs }
    it { is_expected.to have_one(:payment) }
    it { is_expected.to have_one(:featured_image) }
    it { is_expected.to have_one(:nda).dependent :destroy }
    it { is_expected.to have_one(:billing_address).dependent :destroy }
    it { is_expected.to have_many(:spots).dependent(:destroy) }
    it { is_expected.to have_many(:designers).through(:spots) }
    it { is_expected.to belong_to(:packaging_measurements).dependent(:destroy).optional }

    it { is_expected.to have_many(:inspirations).class_name(ProjectInspiration).dependent(:destroy) }
    it { is_expected.to have_many(:existing_logos).class_name(ProjectExistingLogo).dependent(:destroy) }
    it { is_expected.to have_many(:brand_examples).class_name(ProjectBrandExample).dependent(:destroy) }
  end

  describe 'columns' do
    describe 'style step properties' do
      options = { null: false, default: 5 }

      it { is_expected.to have_db_column(:bold_or_refined).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:outmoded_actual).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:value_or_premium).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:detailed_or_clean).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:serious_or_playful).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:traditional_or_modern).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:handcrafted_or_minimalist).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:stand_out_or_not_from_the_crowd).of_type(:integer).with_options options }
    end

    describe 'target audience step properties' do
      options = { null: false, default: 5 }

      it { is_expected.to have_db_column(:youthful_or_mature).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:masculine_or_premium).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:low_income_or_high_income).of_type(:integer).with_options options }
      it { is_expected.to have_db_column(:target_country_codes).of_type(:string).with_options array: true, default: [] }
    end

    describe 'finish step properties' do
      options = { null: false, default: '' }

      it { is_expected.to have_db_column(:slogan).of_type(:string).with_options options }
      it { is_expected.to have_db_column(:brand_name).of_type(:string).with_options options }
      it { is_expected.to have_db_column(:additional_text).of_type(:string).with_options options }
      it { is_expected.to have_db_column(:company_description).of_type(:string).with_options options }
      it { is_expected.to have_db_column(:ideas_or_special_requirements).of_type(:string).with_options options }

      it { is_expected.to have_db_column(:colors_comment).of_type(:string) }
    end

    describe 'details step properties' do
      it { is_expected.to have_db_column(:description).of_type :string }
      it { is_expected.to have_db_column(:normalized_price).of_type :integer }
      it { is_expected.to have_db_column(:name).of_type(:string).with_options index: true }
      it { is_expected.to have_db_column(:upgrade_package).of_type(:boolean).with_options null: false, default: false }
      it { is_expected.to have_db_column(:business_customer).of_type(:boolean).with_options null: false, default: true }
    end

    describe 'stationery properties' do
      it { is_expected.to have_db_column(:compliment).of_type :string }
      it { is_expected.to have_db_column(:letter_head).of_type :string }

      it { is_expected.to have_db_column(:back_business_card_details).of_type :string }
      it { is_expected.to have_db_column(:front_business_card_details).of_type :string }
    end
  end

  describe 'validations' do
    range = 0..10

    it { is_expected.to validate_uniqueness_of(:name).allow_blank }

    # Step #2 - style options

    it { is_expected.to validate_inclusion_of(:bold_or_refined).in_range range }
    it { is_expected.to validate_inclusion_of(:outmoded_actual).in_range range }
    it { is_expected.to validate_inclusion_of(:value_or_premium).in_range range }
    it { is_expected.to validate_inclusion_of(:detailed_or_clean).in_range range }
    it { is_expected.to validate_inclusion_of(:serious_or_playful).in_range range }
    it { is_expected.to validate_inclusion_of(:traditional_or_modern).in_range range }
    it { is_expected.to validate_inclusion_of(:handcrafted_or_minimalist).in_range range }
    it { is_expected.to validate_inclusion_of(:stand_out_or_not_from_the_crowd).in_range range }

    # Step #3 - target audience options

    it { is_expected.to validate_inclusion_of(:youthful_or_mature).in_range range }
    it { is_expected.to validate_inclusion_of(:masculine_or_premium).in_range range }
    it { is_expected.to validate_inclusion_of(:low_income_or_high_income).in_range range }

    it { is_expected.to validate_presence_of(:max_spots_count) }
    it do
      is_expected.to validate_numericality_of(:max_spots_count)
        .is_greater_than_or_equal_to(3)
        .is_less_than_or_equal_to(10)
    end
  end

  describe 'scopes' do
    before do
      PROJECT_STATES.each do |state|
        create(:project, state: state)
      end
    end

    let(:client_projects_states) do
      [
        Project::STATE_DRAFT,
        Project::STATE_CANCELED,
        Project::STATE_COMPLETED,
        Project::STATE_FILES_STAGE,
        Project::STATE_DESIGN_STAGE,
        Project::STATE_REVIEW_FILES,
        Project::STATE_FINALIST_STAGE,
        Project::STATE_WAITING_FOR_DETAILS,
        Project::STATE_WAITING_FOR_PAYMENT,
        Project::STATE_WAITING_FOR_CHECKOUT,
        Project::STATE_WAITING_FOR_STYLE_DETAILS,
        Project::STATE_WAITING_FOR_FINISH_DETAILS,
        Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
        Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
        Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS
      ].map(&:to_s)
    end

    let(:public_checkout_states) do
      [
        Project::STATE_DRAFT,
        Project::STATE_WAITING_FOR_STYLE_DETAILS,
        Project::STATE_WAITING_FOR_FINISH_DETAILS,
        Project::STATE_WAITING_FOR_AUDIENCE_DETAILS
      ].map(&:to_s)
    end

    let(:checkout_states) do
      [
        Project::STATE_WAITING_FOR_DETAILS,
        Project::STATE_WAITING_FOR_PAYMENT,
        Project::STATE_WAITING_FOR_CHECKOUT,
        Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
        Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS
      ].map(&:to_s)
    end

    let(:discover_states) do
      [
        Project::STATE_COMPLETED,
        Project::STATE_FILES_STAGE,
        Project::STATE_REVIEW_FILES,
        Project::STATE_DESIGN_STAGE,
        Project::STATE_FINALIST_STAGE
      ].map(&:to_s)
    end

    let(:unfinished_states) do
      [
        Project::STATE_DRAFT,
        Project::STATE_WAITING_FOR_DETAILS,
        Project::STATE_WAITING_FOR_CHECKOUT,
        Project::STATE_WAITING_FOR_STYLE_DETAILS,
        Project::STATE_WAITING_FOR_FINISH_DETAILS,
        Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
        Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
        Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS
      ].map(&:to_s)
    end

    it { expect(Project.client_projects.map(&:state)).to match_array(client_projects_states) }
    it { expect(Project.public_checkout.map(&:state)).to match_array(public_checkout_states) }
    it { expect(Project.checkout.map(&:state)).to match_array(checkout_states) }
    it { expect(Project.discover.map(&:state)).to match_array(discover_states) }
    it { expect(Project.unfinished.map(&:state)).to match_array(unfinished_states) }

    it { expect(Project.client_projects.map(&:state)).not_to match_array(PROJECT_STATES - client_projects_states) }
    it { expect(Project.public_checkout.map(&:state)).not_to match_array(PROJECT_STATES - public_checkout_states) }
    it { expect(Project.checkout.map(&:state)).not_to match_array(PROJECT_STATES - checkout_states) }
    it { expect(Project.discover.map(&:state)).not_to match_array(PROJECT_STATES - discover_states) }
    it { expect(Project.unfinished.map(&:state)).not_to match_array(PROJECT_STATES - unfinished_states) }

    it { expect(Project.logo_or_brand_identity.distinct.pluck(:project_type)).to match_array(['logo', 'brand_identity']) }
  end

  describe 'events' do
    subject { create(:project) }

    it {
      is_expected.to transition_from(:draft)
        .to(:waiting_for_style_details).on_event(:finish_brand_examples)
    }
    it {
      is_expected.to transition_from(:draft)
        .to(:waiting_for_style_details).on_event(:finish_packaging_measurements)
    }
    it {
      is_expected.to transition_from(:waiting_for_style_details)
        .to(:waiting_for_audience_details).on_event(:finish_style_details)
    }
    it {
      is_expected.to transition_from(:waiting_for_audience_details)
        .to(:waiting_for_finish_details).on_event(:finish_audience_details)
    }
    it {
      is_expected.to transition_from(:waiting_for_finish_details)
        .to(:waiting_for_details).on_event(:finish_public_steps)
    }
    it {
      is_expected.to transition_from(:waiting_for_details)
        .to(:waiting_for_checkout).on_event(:finish_details)
    }
    it {
      is_expected.to transition_from(:waiting_for_payment)
        .to(:design_stage).on_event(:approve_bank_transfer)
    }
    it {
      is_expected.to transition_from(:waiting_for_payment_and_stationery_details)
        .to(:waiting_for_stationery_details).on_event(:approve_bank_transfer)
    }
    it {
      is_expected.to transition_from(:waiting_for_payment_and_stationery_details)
        .to(:waiting_for_payment).on_event(:filled_stationery)
    }
    it {
      is_expected.to transition_from(:waiting_for_stationery_details)
        .to(:design_stage).on_event(:filled_stationery)
    }
    it {
      is_expected.to transition_from(:finalist_stage)
        .to(:files_stage).on_event(:select_winner)
    }
    it {
      is_expected.to transition_from(:files_stage)
        .to(:review_files).on_event(:upload_files)
    }
    it {
      is_expected.to transition_from(:review_files)
        .to(:completed).on_event(:approve_files)
    }
    it { is_expected.to allow_transition_to(:canceled) }
    it { is_expected.to allow_transition_to(:error) }
    it { is_expected.to allow_event(:error) }
    it { is_expected.to allow_event(:cancel) }

    describe 'client_paid' do
      subject do
        create(:project,
               state: Project::STATE_WAITING_FOR_CHECKOUT,
               design_stage_started_at: nil,
               design_stage_expires_at: nil)
      end

      context 'brand_identity project type' do
        before do
          allow(subject).to receive(:brand_identity?).and_return(true)
        end

        it 'does not broadcast payment_received' do
          expect { subject.client_paid! }
            .not_to broadcast(:payment_received)
        end

        it 'does not update design_stage_started_at' do
          expect_any_instance_of(Projects::SetStageTime).not_to receive(:call)
          subject.client_paid!
          expect(subject.design_stage_started_at).to be_blank
          expect(subject.design_stage_expires_at).to be_blank
        end

        it {
          is_expected.not_to transition_from(:waiting_for_checkout)
            .to(:design_stage).on_event(:client_paid)
        }
        it {
          is_expected.to transition_from(:waiting_for_checkout)
            .to(:waiting_for_stationery_details).on_event(:client_paid)
        }
      end

      context 'not brand_identity project type' do
        before do
          allow(subject).to receive(:brand_identity?).and_return(false)
        end

        it 'broadcasts payment_received' do
          expect { subject.client_paid! }
            .to broadcast(:payment_received)
        end

        it 'updates design_stage_started_at' do
          expect(Projects::SetStageTime).to receive(:new)
            .with(Project, :design_stage)
            .and_call_original
          expect_any_instance_of(Projects::SetStageTime).to receive(:call)
            .and_call_original
          subject.client_paid!

          expect(subject.design_stage_started_at).to be_present
          expect(subject.design_stage_expires_at).to be_present
        end

        it {
          is_expected.not_to transition_from(:waiting_for_checkout)
            .to(:waiting_for_stationery_details).on_event(:client_paid)
        }
        it {
          is_expected.to transition_from(:waiting_for_checkout)
            .to(:design_stage).on_event(:client_paid)
        }
      end
    end

    describe 'select_bank_transfer' do
      it 'brand_identity project type' do
        allow(subject).to receive(:brand_identity?).and_return(true)

        expect(subject).not_to transition_from(:waiting_for_checkout)
          .to(:waiting_for_payment).on_event(:select_bank_transfer)
        expect(subject).to transition_from(:waiting_for_checkout)
          .to(:waiting_for_payment_and_stationery_details).on_event(:select_bank_transfer)
      end

      it 'not brand_identity project type' do
        allow(subject).to receive(:brand_identity?).and_return(false)

        expect(subject).to transition_from(:waiting_for_checkout)
          .to(:waiting_for_payment).on_event(:select_bank_transfer)
        expect(subject).not_to transition_from(:waiting_for_checkout)
          .to(:waiting_for_payment_and_stationery_details).on_event(:select_bank_transfer)
      end
    end

    describe 'approve_bank_transfer' do
      context 'waiting_for_payment project state' do
        subject do
          create(:project,
                 state: Project::STATE_WAITING_FOR_PAYMENT,
                 design_stage_started_at: nil,
                 design_stage_expires_at: nil)
        end

        it 'broadcasts bank_transfer_payment_received' do
          expect { subject.approve_bank_transfer! }
            .to broadcast(:bank_transfer_payment_received)
        end

        it 'updates design_stage_started_at' do
          expect(Projects::SetStageTime).to receive(:new)
            .with(Project, :design_stage)
            .and_call_original
          expect_any_instance_of(Projects::SetStageTime).to receive(:call)
            .and_call_original
          subject.approve_bank_transfer!

          expect(subject.design_stage_started_at).not_to be nil
          expect(subject.design_stage_expires_at).not_to be nil
        end
      end

      context 'waiting_for_payment_and_stationery_details project state' do
        subject do
          create(:project,
                 state: Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS,
                 design_stage_started_at: nil,
                 design_stage_expires_at: nil)
        end

        it 'broadcasts bank_transfer_payment_received' do
          expect { subject.approve_bank_transfer! }
            .not_to broadcast(:bank_transfer_payment_received)
        end

        it 'updates design_stage_started_at' do
          subject.approve_bank_transfer!

          expect(subject.design_stage_started_at).to be nil
          expect(subject.design_stage_expires_at).to be nil
        end
      end
    end

    describe 'filled_stationery' do
      context 'waiting_for_stationery_details project state' do
        subject do
          create(:project,
                 state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
                 design_stage_started_at: nil,
                 design_stage_expires_at: nil)
        end

        it 'broadcasts payment_received' do
          expect { subject.filled_stationery! }
            .to broadcast(:payment_received)
        end

        it 'updates design_stage_started_at' do
          expect(Projects::SetStageTime).to receive(:new)
            .with(Project, :design_stage)
            .and_call_original
          expect_any_instance_of(Projects::SetStageTime).to receive(:call)
            .and_call_original
          subject.filled_stationery!

          expect(subject.design_stage_started_at).not_to be nil
          expect(subject.design_stage_expires_at).not_to be nil
        end
      end

      context 'waiting_for_payment_and_stationery_details project state' do
        subject do
          create(:project,
                 state: Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS,
                 design_stage_started_at: nil,
                 design_stage_expires_at: nil)
        end

        it 'broadcasts payment_received' do
          expect { subject.filled_stationery! }
            .not_to broadcast(:payment_received)
        end

        it 'updates design_stage_started_at' do
          subject.filled_stationery!

          expect(subject.design_stage_started_at).to be nil
          expect(subject.design_stage_expires_at).to be nil
        end
      end
    end

    describe 'finalist_stage' do
      subject do
        create(:project,
               state: Project::STATE_DESIGN_STAGE,
               finalist_stage_started_at: nil,
               finalist_stage_expires_at: nil)
      end

      context 'finalist_count_enough_for_finalist_stage? returns true' do
        before do
          allow(subject).to receive(:finalist_count_enough_for_finalist_stage?).and_return(true)
        end

        it 'broadcasts finalist_stage_started' do
          expect { subject.finalist_stage! }
            .to broadcast(:finalist_stage_started)
        end

        it 'updates finalist_stage_started_at' do
          expect(Projects::SetStageTime).to receive(:new)
            .with(Project, :finalist_stage)
            .and_call_original
          expect_any_instance_of(Projects::SetStageTime).to receive(:call)
            .and_call_original
          subject.finalist_stage!

          expect(subject.design_stage_started_at).not_to be nil
          expect(subject.design_stage_expires_at).not_to be nil
        end

        it { is_expected.to transition_from(:design_stage).to(:finalist_stage).on_event(:finalist_stage) }
      end

      context 'finalist_count_enough_for_finalist_stage? returns false' do
        before do
          allow(subject).to receive(:finalist_count_enough_for_finalist_stage?).and_return(false)
        end

        it 'to railse an error' do
          expect { subject.finalist_stage! }
            .to raise_error(AASM::InvalidTransition)
        end
      end
    end

    describe 'select_winner' do
      subject do
        create(:project,
               state: Project::STATE_FINALIST_STAGE,
               files_stage_started_at: nil,
               files_stage_expires_at: nil)
      end

      it 'broadcasts files_stage_started' do
        expect { subject.select_winner! }
          .to broadcast(:files_stage_started)
      end

      it 'updates winner_selected_stage_started_at' do
        expect(Projects::SetStageTime).to receive(:new)
          .with(Project, :files_stage)
          .and_call_original
        expect_any_instance_of(Projects::SetStageTime).to receive(:call)
          .and_call_original
        subject.select_winner!

        expect(subject.design_stage_started_at).not_to be nil
        expect(subject.design_stage_expires_at).not_to be nil
      end
    end

    describe 'upload_files' do
      subject do
        create(:project,
               state: Project::STATE_FILES_STAGE,
               files_stage_started_at: nil,
               files_stage_expires_at: nil)
      end

      it 'updates winner_selected_stage_started_at' do
        expect(Projects::SetStageTime).to receive(:new)
          .with(Project, :review_files_stage)
          .and_call_original
        expect_any_instance_of(Projects::SetStageTime).to receive(:call)
          .and_call_original
        subject.upload_files!

        expect(subject.design_stage_started_at).not_to be nil
        expect(subject.design_stage_expires_at).not_to be nil
      end
    end

    describe 'abandoned_cart_reminder_step events' do
      describe 'send_next_reminder' do
        let(:project) { create(:project, abandoned_cart_reminder_step: step) }
        let(:step) { :first_reminder }

        describe 'abandoned_cart_reminder_step eq first_reminder' do
          it 'can be transitioned' do
            expect_any_instance_of(Projects::AbandonedCartReminders::Send).to receive(:call)
            expect(project).to transition_from(:first_reminder)
              .to(:second_reminder).on_event(:send_next_reminder)
              .on(:abandoned_cart_reminder_step)
          end

          describe 'not allowed transitions' do
            it 'third_reminder' do
              expect(project).not_to transition_from(:first_reminder)
                .to(:third_reminder).on_event(:send_next_reminder)
                .on(:abandoned_cart_reminder_step)
            end

            it 'reminding_completed' do
              expect(project).not_to transition_from(:first_reminder)
                .to(:reminding_completed).on_event(:send_next_reminder)
                .on(:abandoned_cart_reminder_step)
            end
          end
        end

        describe 'abandoned_cart_reminder_step eq second_reminder' do
          let(:step) { :second_reminder }

          it 'can be transitioned' do
            expect_any_instance_of(Projects::AbandonedCartReminders::Send).to receive(:call)
            expect(project).to transition_from(:second_reminder)
              .to(:third_reminder).on_event(:send_next_reminder)
              .on(:abandoned_cart_reminder_step)
          end

          describe 'not allowed transitions' do
            it 'first_reminder' do
              expect(project).not_to transition_from(:second_reminder)
                .to(:first_reminder).on_event(:send_next_reminder)
                .on(:abandoned_cart_reminder_step)
            end

            it 'reminding_completed' do
              expect(project).not_to transition_from(:second_reminder)
                .to(:reminding_completed).on_event(:send_next_reminder)
                .on(:abandoned_cart_reminder_step)
            end
          end
        end

        describe 'abandoned_cart_reminder_step eq third_reminder' do
          let(:step) { :second_reminder }

          it 'can be transitioned' do
            expect_any_instance_of(Projects::AbandonedCartReminders::Send).to receive(:call)
            expect(project).to transition_from(:third_reminder)
              .to(:reminding_completed).on_event(:send_next_reminder)
              .on(:abandoned_cart_reminder_step)
          end

          describe 'not allowed transitions' do
            it 'first_reminder' do
              expect(project).not_to transition_from(:third_reminder)
                .to(:first_reminder).on_event(:send_next_reminder)
                .on(:abandoned_cart_reminder_step)
            end

            it 'second_reminder' do
              expect(project).not_to transition_from(:third_reminder)
                .to(:second_reminder_completed).on_event(:send_next_reminder)
                .on(:abandoned_cart_reminder_step)
            end
          end
        end
      end
    end
  end

  describe '#has_available_spot_for?' do
    context 'project has available spot' do
      it 'returns true' do
        project = create(:project)
        designer = create(:designer)

        result = project.has_available_spot_for?(designer)

        expect(result).to eq(true)
      end
    end

    context 'project has not available spot' do
      it 'returns false' do
        project = create(:project)
        designer = create(:designer)

        create_list(:reserved_spot, project.max_spots_count, project: project)

        result = project.has_available_spot_for?(designer)

        expect(result).to be_falsey
      end
    end

    context 'designer already reserve a spot' do
      it 'returns false' do
        project = create(:project)
        designer = create(:designer)

        create(:reserved_spot, project: project, designer: designer)

        result = project.has_available_spot_for?(designer)

        expect(result).to be_falsey
      end
    end

    context 'designer already reserve a spot and upload design' do
      it 'returns false' do
        project  = create(:project)
        designer = create(:designer)

        create(:design, project: project, designer: designer)

        result = project.has_available_spot_for?(designer)

        expect(result).to be_truthy
      end
    end
  end

  describe '#queue_available_for?' do
    context 'designer already in queue' do
      it 'returns false' do
        project = create(:project)
        designer = create(:designer)

        create(:spot, project: project, designer: designer, state: Spot::STATE_IN_QUEUE)

        result = project.queue_available_for?(designer)

        expect(result).to be_falsey
      end
    end

    context 'designer already reserve a spot but upload design' do
      it 'returns true' do
        project = create(:project)
        designer = create(:designer)

        create(:design, project: project, designer: designer)

        result = project.queue_available_for?(designer)

        expect(result).to be_truthy
      end
    end

    context 'designer already reserve a spot' do
      it 'returns false' do
        project = create(:project)
        designer = create(:designer)

        create(:reserved_spot, project: project, designer: designer)

        result = project.queue_available_for?(designer)

        expect(result).to be_falsey
      end
    end
  end

  describe '#finalists' do
    it 'returns designers who is finalists in this project' do
      designer1, designer2, designer3 = create_list(:designer, 3)
      project = create(:project, state: Project::STATE_FINALIST_STAGE)

      create(:finalist_design, project: project, designer: designer1)
      create(:finalist_design, project: project, designer: designer2)
      create(:design, project: project, designer: designer3)

      project.reload
      finalists = project.finalists

      expect(finalists).to include(designer1)
      expect(finalists).to include(designer2)

      expect(finalists.size).to eq(2)
    end
  end

  describe '#project_type_price' do
    [:logo, :packaging, :brand_identity].each do |type|
      it "should return $123.5 for #{type} project" do
        ProjectPrice.create(project_type: type, price: 123.5)

        project = create(:project, project_type: type)
        expect(project.project_type_price).to eq 123.5
      end
    end
  end

  describe '#can_be_reserved?' do
    AVAILABLE_RESERVE_STATES.each do |state|
      it "returns true for project in #{state} state" do
        project = create(:project, state: state)

        result = project.can_be_reserved?

        expect(result).to eq(true)
      end
    end

    NOT_AVAILABLE_RESERVE_STATES.each do |state|
      it 'returns false for states that unavailable for reserve' do
        project = create(:project, state: state)

        result = project.can_be_reserved?

        expect(result).to eq(false)
      end
    end
  end

  describe '#has_in_queue?' do
    it 'returns true if designer in queue' do
      designer = create(:designer)
      project  = create(:project)

      create(:spot, state: Spot::STATE_IN_QUEUE, designer: designer, project: project)

      result = project.has_in_queue?(designer)

      expect(result).to eq(true)
    end

    it 'returns false if designer not in queue' do
      designer = create(:designer)
      project  = create(:project)

      create(:reserved_spot, designer: designer, project: project)

      result = project.has_in_queue?(designer)

      expect(result).to eq(false)
    end
  end

  describe '#can_be_reserved_by?' do
    it 'returns true if queue available for designer' do
      designer = create(:designer)
      project = create(:project, state: Project::STATE_DESIGN_STAGE)

      create_list(:reserved_spot, 10, project: project)

      result = project.can_be_reserved_by?(designer)

      expect(result).to eq(true)
    end

    it 'returns true if designer can reserve slot' do
      designer = create(:designer)
      project = create(:project, state: :design_stage)

      result = project.can_be_reserved_by?(designer)

      expect(result).to eq(true)
    end

    it 'returns false if designer cannot reserve slot and join queue' do
      designer = create(:designer)
      project = create(:project, state: Project::STATE_DESIGN_STAGE)

      create_list(:reserved_spot, 9, project: project)
      create(:reserved_spot, designer: designer, project: project)

      result = project.can_be_reserved_by?(designer)

      expect(result).to eq(false)
    end
  end

  describe '#is_blocked?' do
    it 'returns true' do
      project = create(:project)
      client  = project.client

      block    = create(:designer_client_block, client: client)
      designer = block.designer

      expect(project.is_blocked?(designer)).to be_truthy
    end

    describe 'returns false' do
      it 'when client did not block designer' do
        project  = create(:project)
        designer = create(:designer)

        expect(project.is_blocked?(designer)).to be_falsey
      end

      it 'when project does not have client ref' do
        project  = create(:project, client: nil)
        designer = create(:designer)

        expect(project.is_blocked?(designer)).to be_falsey
      end
    end
  end

  describe '#all_finalists_selected?' do
    subject do
      create(:project, spots: [
               create(:finalist_design).spot,
               create(:stationery_design).spot,
               create(:stationery_uploaded_design).spot
             ])
    end

    it { expect(subject.all_finalists_selected?).to be_truthy }
  end
end
