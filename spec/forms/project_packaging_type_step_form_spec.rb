# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectPackagingTypeStepForm do
  describe '#save' do
    describe 'valid attributes' do
      it 'successfully updates existing project in DB (type: can)' do
        measurements_attributes = attributes_for(
          :can_packaging_measurements
        )

        project = create(:project, state: :waiting_for_audience_details)

        attributes = measurements_attributes.merge(
          upgrade_project_state: true,
          packaging_type: 'can',
          id: project.id
        )

        form = ProjectPackagingTypeStepForm.new(attributes)

        expect(form.valid?).to be_truthy

        expect { form.save }.to change { Project.count }.by 0

        expect(form.project.project_type).to eq 'packaging'

        measurements = form.project.packaging_measurements

        expect(measurements).to be_persisted
        expect(measurements.class).to eq CanPackagingMeasurements

        measurements_attributes.each do |field_name, expected_value|
          actual_value = measurements.public_send(field_name)
          expect(actual_value).to eq(expected_value)
        end

        expect(form.project.state).to eq 'waiting_for_audience_details'
      end
    end
  end

  describe 'validations', type: :model do
    it { is_expected.to validate_presence_of :packaging_type }

    describe 'technical drawing is specified' do
      let(:technical_drawing) { create(:technical_drawing) }

      subject do
        ProjectPackagingTypeStepForm.new(
          technical_drawing_id: technical_drawing.id,
          upgrade_project_state: true
        )
      end

      # can props
      it { is_expected.not_to validate_presence_of :height }
      it { is_expected.not_to validate_presence_of :volume }
      it { is_expected.not_to validate_presence_of :diameter }

      # bottle props
      it { is_expected.not_to validate_presence_of :label_width }
      it { is_expected.not_to validate_presence_of :label_height }

      # card box props
      it { is_expected.not_to validate_presence_of :side_depth }
      it { is_expected.not_to validate_presence_of :front_width }
      it { is_expected.not_to validate_presence_of :front_height }

      # pouch props
      it { is_expected.not_to validate_presence_of :width }
      it { is_expected.not_to validate_presence_of :height }
    end

    describe 'technical drawing is not specified' do
      describe 'type: can' do
        subject { ProjectPackagingTypeStepForm.new(packaging_type: 'can', upgrade_project_state: true) }

        # can props
        it { is_expected.to validate_presence_of :height }
        it { is_expected.to validate_presence_of :volume }
        it { is_expected.to validate_presence_of :diameter }

        # bottle props
        it { is_expected.not_to validate_presence_of :label_width }
        it { is_expected.not_to validate_presence_of :label_height }

        # card box props
        it { is_expected.not_to validate_presence_of :side_depth }
        it { is_expected.not_to validate_presence_of :front_width }
        it { is_expected.not_to validate_presence_of :front_height }

        # pouch props
        it { is_expected.not_to validate_presence_of :width }
      end

      describe 'type: bottle' do
        subject { ProjectPackagingTypeStepForm.new(packaging_type: 'bottle', upgrade_project_state: true) }

        # bottle props
        it { is_expected.to validate_presence_of :label_width }
        it { is_expected.to validate_presence_of :label_height }

        # can props
        it { is_expected.not_to validate_presence_of :height }
        it { is_expected.not_to validate_presence_of :volume }
        it { is_expected.not_to validate_presence_of :diameter }

        # card box props
        it { is_expected.not_to validate_presence_of :side_depth }
        it { is_expected.not_to validate_presence_of :front_width }
        it { is_expected.not_to validate_presence_of :front_height }

        # pouch props
        it { is_expected.not_to validate_presence_of :width }
        it { is_expected.not_to validate_presence_of :height }
      end

      describe 'type: card box' do
        subject { ProjectPackagingTypeStepForm.new(packaging_type: 'card_box', upgrade_project_state: true) }

        # card box props
        it { is_expected.to validate_presence_of :side_depth }
        it { is_expected.to validate_presence_of :front_width }
        it { is_expected.to validate_presence_of :front_height }

        # can props
        it { is_expected.not_to validate_presence_of :height }
        it { is_expected.not_to validate_presence_of :volume }
        it { is_expected.not_to validate_presence_of :diameter }

        # bottle props
        it { is_expected.not_to validate_presence_of :label_width }
        it { is_expected.not_to validate_presence_of :label_height }

        # pouch props
        it { is_expected.not_to validate_presence_of :width }
        it { is_expected.not_to validate_presence_of :height }
      end

      describe 'type: pouch' do
        subject { ProjectPackagingTypeStepForm.new(packaging_type: 'pouch', upgrade_project_state: true) }

        # pouch props
        it { is_expected.to validate_presence_of :width }
        it { is_expected.to validate_presence_of :height }

        # can props
        it { is_expected.not_to validate_presence_of :volume }
        it { is_expected.not_to validate_presence_of :diameter }

        # bottle props
        it { is_expected.not_to validate_presence_of :label_width }
        it { is_expected.not_to validate_presence_of :label_height }

        # card box props
        it { is_expected.not_to validate_presence_of :side_depth }
        it { is_expected.not_to validate_presence_of :front_width }
        it { is_expected.not_to validate_presence_of :front_height }
      end
    end

    describe 'form data is specified (type: can)' do
      let(:measurements_attributes) { attributes_for(:can_packaging_measurements) }

      describe 'technical drawing is not specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            measurements_attributes.merge(
              packaging_type: 'can',
              upgrade_project_state: true
            )
          )
        end

        it { is_expected.not_to validate_presence_of :technical_drawing_id }
      end

      describe 'wrong technical drawing is specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            measurements_attributes.merge(
              technical_drawing_id: 'abc',
              upgrade_project_state: true,
              packaging_type: 'can'
            )
          )
        end

        it { is_expected.not_to validate_presence_of :height }
        it { is_expected.not_to validate_presence_of :volume }
        it { is_expected.not_to validate_presence_of :diameter }
        it { is_expected.not_to validate_presence_of :technical_drawing_id }
      end
    end

    describe 'form data is specified (type: bottle)' do
      let(:measurements_attributes) { attributes_for(:bottle_packaging_measurements) }

      describe 'technical drawing is not specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            measurements_attributes.merge(
              packaging_type: 'bottle',
              upgrade_project_state: true
            )
          )
        end

        it { is_expected.not_to validate_presence_of :technical_drawing_id }
      end

      describe 'wrong technical drawing is specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            measurements_attributes.merge(
              technical_drawing_id: 'abc',
              packaging_type: 'bottle',
              upgrade_project_state: true
            )
          )
        end

        it { is_expected.not_to validate_presence_of :label_width }
        it { is_expected.not_to validate_presence_of :label_height }
        it { is_expected.not_to validate_presence_of :technical_drawing_id }
      end
    end

    describe 'form data is specified (type: card box)' do
      let(:measurements_attributes) { attributes_for(:card_box_packaging_measurements) }

      describe 'technical drawing is not specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            measurements_attributes.merge(
              packaging_type: 'card_box',
              upgrade_project_state: true
            )
          )
        end

        it { is_expected.not_to validate_presence_of :technical_drawing_id }
      end

      describe 'wrong technical drawing is specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            measurements_attributes.merge(
              technical_drawing_id: 'abc',
              packaging_type: 'card_box',
              upgrade_project_state: true
            )
          )
        end

        it { is_expected.not_to validate_presence_of :side_depth }
        it { is_expected.not_to validate_presence_of :front_width }
        it { is_expected.not_to validate_presence_of :front_height }
        it { is_expected.not_to validate_presence_of :technical_drawing_id }
      end
    end

    describe 'form data is specified (type: pouch)' do
      let(:measurements_attributes) { attributes_for(:pouch_packaging_measurements) }

      describe 'technical drawing is not specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            measurements_attributes.merge(
              packaging_type: 'pouch'
            )
          )
        end

        it { is_expected.not_to validate_presence_of :technical_drawing_id }
      end

      describe 'wrong technical drawing is specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            measurements_attributes.merge(
              technical_drawing_id: 'abc',
              packaging_type: 'pouch',
              upgrade_project_state: true
            )
          )
        end

        it { is_expected.not_to validate_presence_of :width }
        it { is_expected.not_to validate_presence_of :height }
        it { is_expected.not_to validate_presence_of :technical_drawing_id }
      end
    end

    describe 'form data is specified (type: plastic pack)' do
      describe 'technical drawing is not specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            packaging_type: 'plastic_pack',
            upgrade_project_state: true
          )
        end

        it { is_expected.to validate_presence_of :technical_drawing_id }
      end

      describe 'wrong technical drawing is specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            packaging_type: 'plastic_pack',
            technical_drawing_id: 'abc',
            upgrade_project_state: true
          )
        end

        it { is_expected.to validate_presence_of :technical_drawing_id }
      end
    end

    describe 'form data is not specified' do
      subject { ProjectPackagingTypeStepForm.new(upgrade_project_state: true) }

      it { is_expected.to validate_presence_of :technical_drawing_id }

      describe 'wrong technical drawing is specified' do
        subject do
          ProjectPackagingTypeStepForm.new(
            technical_drawing_id: 'abc',
            upgrade_project_state: true
          )
        end

        it { is_expected.to validate_presence_of :technical_drawing_id }
      end
    end
  end
end
