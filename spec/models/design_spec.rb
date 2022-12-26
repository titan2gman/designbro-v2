# frozen_string_literal: true

require 'rails_helper'

DESIGN_DELEGATED_METHODS = [:state, :winner?, :finalist?, :eliminate!, :mark_as_winner!, :mark_as_finalist!, :approve_stationery!, :can_be_eliminated?].freeze

RSpec.describe Design do
  describe 'columns' do
    # it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    # it { is_expected.to have_db_column(:rating).of_type(:integer).with_options(null: false, default: 0) }
    # it { is_expected.to have_db_column(:spot_id).of_type(:integer).with_options(null: false, index: true) }
    # it { is_expected.to have_db_column(:uploaded_file_id).of_type(:integer).with_options(null: false, index: true) }
    it do
      is_expected.to define_enum_for(:eliminate_reason)
        .with_values(
          not_in_line: 0,
          not_communicate: 1,
          not_understand: 2,
          looking_for_something_else: 3,
          other: 4
        )
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:spot) }

    it { is_expected.to have_one(:project).through(:spot) }
    it { is_expected.to have_one(:designer).through(:spot) }
    it { is_expected.to have_one(:product).through(:project) }

    it { is_expected.to have_many(:direct_conversation_messages).dependent(:destroy) }
    it { is_expected.to have_many(:reviews).dependent(:destroy) }

    it { is_expected.to belong_to(:uploaded_file).class_name(UploadedFile::DesignFile).dependent(:destroy).validate(true) }
  end

  describe 'scopes' do
    let(:first_spot) { create(:spot, state: :reserved) }
    let(:second_spot) { create(:spot, state: :reserved) }

    context '.not_eliminated' do
      let(:design_with_spot_eliminated) { create(:design, spot: first_spot) }
      let(:design_with_spot_not_eliminated) { create(:design, spot: second_spot) }

      before do
        design_with_spot_eliminated.spot.eliminate!
        design_with_spot_not_eliminated.spot.mark_as_finalist!
      end

      it 'returns designs with not eliminated spots' do
        expect(described_class.not_eliminated).to match_array([design_with_spot_not_eliminated])
      end
    end

    context '.finalist' do
      let(:design_with_spot_finalist) { create(:design, spot: first_spot) }
      let(:design_with_spot_not_finalist) { create(:design, spot: second_spot) }

      before do
        design_with_spot_finalist.spot.mark_as_finalist!
        design_with_spot_not_finalist.spot.eliminate!
      end

      it 'returns designs with finalist spots' do
        expect(described_class.finalist).to match_array([design_with_spot_finalist])
      end
    end

    context '.visible' do
      Spot::VISIBLE_STATES.each do |state|
        describe state.to_s do
          it 'returns designs with visible spots' do
            design = create(:design)
            invis_design = create(:design)
            invis_design.spot.update_column(:state, 'queue')
            design.spot.update_column(:state, state)
            design.valid?
            expect(described_class.visible).to match_array([design])
          end
        end
      end
    end

    context '.by_spot_state' do
      let(:first_design) { create(:design) }
      let(:second_design) { create(:design) }

      before do
        second_design.spot.mark_as_finalist!
      end

      it 'returns spot by state' do
        scoped = Design.by_spot_state('finalist')

        expect(scoped.count).to eq(1)
        expect(scoped.first).to eq(second_design)
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:name).is_at_most(30) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:uploaded_file) }

    it do
      is_expected.to validate_numericality_of(:rating)
        .is_greater_than_or_equal_to(0)
        .is_less_than_or_equal_to(5)
        .only_integer
        .allow_nil
    end
    describe 'spot' do
      describe 'state' do
        describe 'create' do
          [Spot::STATE_RESERVED].each do |state|
            describe state.to_s do
              it 'should be valid' do
                spot   = create(:spot, state: state)
                design = build(:design, spot: spot)

                design.valid?

                expect(design.errors[:spot]).to be_empty
              end
            end
          end

          [
            Spot::STATE_AVAILABLE,
            Spot::STATE_IN_QUEUE,
            Spot::STATE_DESIGN_UPLOADED,
            Spot::STATE_EXPIRED,
            Spot::STATE_FINALIST,
            Spot::STATE_WINNER,
            Spot::STATE_ELIMINATED
          ].each do |state|
            describe state.to_s do
              it 'should not be valid' do
                spot   = create(:spot, state: state)
                design = build(:design, spot: spot)

                design.valid?

                expect(design.errors[:spot]).not_to be_empty
              end
            end
          end
        end

        describe 'update' do
          [
            Spot::STATE_RESERVED,
            Spot::STATE_AVAILABLE,
            Spot::STATE_IN_QUEUE,
            Spot::STATE_DESIGN_UPLOADED,
            Spot::STATE_EXPIRED,
            Spot::STATE_FINALIST,
            Spot::STATE_WINNER,
            Spot::STATE_ELIMINATED
          ].each do |state|
            describe state.to_s do
              it 'should be valid' do
                reserved_spot = create(:spot, state: Spot::STATE_RESERVED)
                design        = create(:design, spot: reserved_spot)

                spot = create(:spot, state: state)
                design.assign_attributes(spot: spot)

                design.valid?

                expect(design.errors[:spot]).to be_empty
              end
            end
          end
        end
      end
    end
  end

  DESIGN_DELEGATED_METHODS.each do |method|
    describe "##{method}" do
      let(:design) { create(:design) }

      it 'delegates to spot' do
        expect(design.spot).to receive(method)

        design.public_send(method)
      end
    end
  end

  describe '#project_type' do
    let(:design) { create(:design) }

    it 'delegates to project' do
      expect(design.project).to receive(:project_type)

      design.project_type
    end
  end

  describe '#design_versions' do
    context 'without self-version' do
      it 'adds self to the versions list' do
        file1, file2 = create_list(:design_file, 2)
        design = create(:design, uploaded_file: file1)

        design.update(uploaded_file: file2)

        versions = design.design_versions

        expect(versions.find { |d| d.uploaded_file == file1 }).to be_truthy
        expect(versions.find { |d| d.uploaded_file == file2 }).to be_truthy

        expect(versions.size).to eq(2)
      end
    end

    context 'with self-version' do
      it 'is does not add version again' do
        file1, file2 = create_list(:design_file, 2)
        design = create(:design, uploaded_file: file1)

        design.update(uploaded_file: file2)
        design.update(uploaded_file: file1)

        versions = design.design_versions

        expect(versions.find { |d| d.uploaded_file == file1 }).to be_truthy
        expect(versions.find { |d| d.uploaded_file == file2 }).to be_truthy

        expect(versions.size).to eq(2)
      end
    end
  end

  describe '#restore' do
    context 'no version exists' do
      it 'it does nothing' do
        file   = create(:design_file)
        design = create(:design)

        result = design.restore(file.id)

        expect(result).to eq(nil)
      end
    end

    context 'version exists' do
      it 'restores given version' do
        file1 = create(:design_file)
        file2 = create(:design_file)
        design = create(:design, uploaded_file: file1)

        design.update(uploaded_file: file2)

        design.restore(file1.id)
        result = design.reload.uploaded_file

        expect(result).to eq(file1)
      end
    end
  end

  context 'class methods' do
    it '.by_spot_state' do
      create(:design)
      create(:design).spot.mark_as_finalist!

      expect(Design.by_spot_state('design_uploaded')
        .map(&:state)).to match(['design_uploaded'])
    end

    it '.by_blocked_flag' do
      design = create(:design)
      blocked_design = create(:design)

      create(:design)
      create(:designer_client_block, designer: blocked_design.designer)

      # expect(Design.by_blocked_flag('blocked')).to match([blocked_design])
      expect(Design.by_blocked_flag('non_blocked')).to match([design])
    end

    it '.ransackable_scopes' do
      expect(Design.ransackable_scopes).to match_array(
        ['by_spot_state', 'by_blocked_flag', 'by_client']
      )
    end
  end
end
