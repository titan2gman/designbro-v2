# frozen_string_literal: true

SPOT_STATES = Spot.aasm.states.map(&:name).map(&:to_s)

SPOT_CAN_BE_ELIMINATED_STATES = [
  Spot::STATE_FINALIST,
  Spot::STATE_DESIGN_UPLOADED,
  Spot::STATE_STATIONERY_UPLOADED
].map(&:to_s)

SPOT_CAN_NOT_BE_ELIMINATED_STATES = (
  SPOT_STATES - SPOT_CAN_BE_ELIMINATED_STATES
).map(&:to_s)

RSpec.describe Spot do
  it_should_behave_like 'spot expire methods'

  describe 'columns' do
    it { is_expected.to have_db_column(:state).of_type(:string) }

    it { is_expected.to have_db_column(:designer_id).of_type(:integer).with_options(null: false, index: true) }
    it { is_expected.to have_db_column(:project_id).of_type(:integer).with_options(null: false, index: true) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:designer) }

    it { is_expected.to have_one(:design).dependent(:destroy) }
    it { is_expected.to have_one(:client).through(:project) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:project) }
    it { is_expected.to validate_presence_of(:designer) }
  end

  describe '#without_design' do
    it 'returns spots that have no designs' do
      spot1 = create(:reserved_spot)
      spot2 = create(:reserved_spot)

      create(:design, spot: spot1)

      result = Spot.without_design

      expect(result).to contain_exactly(spot2)
    end
  end

  describe '#state' do
    subject { build(:spot) }

    it { is_expected.to transition_from(:available).to(:in_queue).on_event(:queue) }
    it { is_expected.to transition_from(:available).to(:reserved).on_event(:reserve) }
    it { is_expected.to transition_from(:in_queue).to(:reserved).on_event(:reserve) }
    it { is_expected.to transition_from(:reserved).to(:design_uploaded).on_event(:upload_design) }
    it { is_expected.to transition_from(:finalist).to(:winner).on_event(:mark_as_winner) }
    it { is_expected.to transition_from(:stationery).to(:stationery_uploaded).on_event(:upload_stationery) }
    it { is_expected.to transition_from(:stationery_uploaded).to(:finalist).on_event(:approve_stationery) }

    it { is_expected.to transition_from(:in_queue).to(:deleted_by_admin).on_event(:mark_as_deleted_by_admin) }
    it { is_expected.to transition_from(:reserved).to(:deleted_by_admin).on_event(:mark_as_deleted_by_admin) }
    it { is_expected.to transition_from(:design_uploaded).to(:deleted_by_admin).on_event(:mark_as_deleted_by_admin) }
    it { is_expected.to transition_from(:stationery).to(:deleted_by_admin).on_event(:mark_as_deleted_by_admin) }
    it { is_expected.to transition_from(:stationery_uploaded).to(:deleted_by_admin).on_event(:mark_as_deleted_by_admin) }
    it { is_expected.to transition_from(:finalist).to(:deleted_by_admin).on_event(:mark_as_deleted_by_admin) }

    it { is_expected.to allow_event(:eliminate) }
    it { is_expected.to allow_event(:block) }

    context 'with brand_identity project' do
      before { allow(subject).to receive(:brand_identity_project?).and_return(true) }

      it { is_expected.to allow_transition_to(:eliminated) }
    end

    context 'with not brand_identity project' do
      before { allow(subject).to receive(:brand_identity_project?).and_return(false) }

      it { is_expected.to allow_transition_to(:eliminated) }
    end

    describe '#reserve' do
      subject { create(:spot, reserved_state_started_at: nil) }

      it 'updates reserved_state_started_at column' do
        subject.reserve!

        expect(subject.reserved_state_started_at).not_to be nil
      end
    end

    describe '#mark_as_finalist' do
      it 'brand_identity project type' do
        allow(subject).to receive(:brand_identity_project?).and_return(true)

        expect(subject).not_to transition_from(:design_uploaded).to(:finalist).on_event(:mark_as_finalist)
        expect(subject).to     transition_from(:design_uploaded).to(:stationery).on_event(:mark_as_finalist)
      end

      it 'not brand_identity project type' do
        allow(subject).to receive(:brand_identity_project?).and_return(false)

        expect(subject).to     transition_from(:design_uploaded).to(:finalist).on_event(:mark_as_finalist)
        expect(subject).not_to transition_from(:design_uploaded).to(:stationery).on_event(:mark_as_finalist)
      end
    end
  end

  describe '#can_be_eliminated?' do
    let(:spot) { Spot.new(state: state) }

    subject { spot.can_be_eliminated? }

    SPOT_CAN_BE_ELIMINATED_STATES.each do |state|
      context "state: #{state}" do
        let(:state) { state }

        it { is_expected.to be_truthy }
      end
    end

    SPOT_CAN_NOT_BE_ELIMINATED_STATES.each do |state|
      context "state: #{state}" do
        let(:state) { state }

        it { is_expected.to be_falsey }
      end
    end
  end

  describe '#publish_design_eliminated' do
    context 'state: :design_uploaded' do
      let(:design) { create(:design) }

      it 'broadcasts :design_eliminated event' do
        expect(design.spot).to receive(:broadcast)
          .with(:design_eliminated, design)

        design.eliminate!
      end
    end

    context 'state: :stationery_uploaded' do
      let(:design) { create(:stationery_uploaded_design) }

      it 'broadcasts :design_eliminated event' do
        expect(design.spot).to receive(:broadcast)
          .with(:design_eliminated, design)

        design.eliminate!
      end
    end
  end
end
