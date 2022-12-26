# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'project expire methods' do
  it_should_behave_like 'time methods'

  let(:model) { described_class.new(attributes_for(:project)) }

  describe 'expired' do
    {
      design_stage_expired?: { timepoint: :design_stage_expires_at },
      finalist_stage_expired?: { timepoint: :finalist_stage_expires_at }
    }.each do |method, attrs|
      describe method.to_s do
        [:logo, :brand_identity, :packaging].each do |project_type|
          let(:model) { described_class.new(project_type: project_type) }

          it 'returns true for expired' do
            model.assign_attributes(attrs[:timepoint] => Time.current - 1.hour)
            expect(model.public_send(method)).to be_truthy

            model.assign_attributes(attrs[:timepoint] => Time.current)
            expect(model.public_send(method)).to be_truthy
          end

          it 'returns false for not expired' do
            model.assign_attributes(attrs[:timepoint] => (Time.current + 1.hour))
            expect(model.public_send(method)).to be_falsey
          end
        end
      end
    end
    {
      files_stage_expired?: { timepoint: :files_stage_expires_at },
      review_files_expired?: { timepoint: :review_files_stage_expires_at }
    }.each do |method, attrs|
      describe method.to_s do
        it 'returns true for expired' do
          model.assign_attributes(attrs[:timepoint] => Time.current - 1.hour)
          expect(model.public_send(method)).to be_truthy

          model.assign_attributes(attrs[:timepoint] => Time.current)
          expect(model.public_send(method)).to be_truthy
        end

        it 'returns false for not expired' do
          model.assign_attributes(attrs[:timepoint] => Time.current + 1.hour)
          expect(model.public_send(method)).to be_falsey
        end
      end
    end
  end

  describe 'warnings' do
    {
      send_three_days_of_design_stage_left_warning?: { timepoint: :design_stage_expires_at, time: 3.days },
      send_one_day_of_design_stage_left_warning?: { timepoint: :design_stage_expires_at, time: 1.day },
      send_two_days_of_finalist_stage_left_warning?: { timepoint: :finalist_stage_expires_at, time: 2.day },
      send_one_day_of_finalist_stage_left_warning?: { timepoint: :finalist_stage_expires_at, time: 1.day }
    }.each do |method, attrs|
      describe method.to_s do
        [:logo, :brand_identity, :packaging].each do |project_type|
          let(:model) { described_class.new(project_type: project_type) }

          it 'returns true for warning time' do
            model.assign_attributes(attrs[:timepoint] => Time.current + attrs[:time])
            expect(model.public_send(method)).to be_truthy
          end

          it 'returns false for not warning time' do
            model.assign_attributes(attrs[:timepoint] => Time.current + attrs[:time] + 1.day)
            expect(model.public_send(method)).to be_falsy
          end
        end
      end
    end

    {
      send_two_days_of_files_stage_left_warning?: { timepoint: :files_stage_expires_at, time: 2.day },
      send_one_day_of_files_stage_left_warning?: { timepoint: :files_stage_expires_at, time: 1.day },
      send_three_days_of_review_files_stage_left_warning?: { timepoint: :review_files_stage_expires_at, time: 3.day }
    }.each do |method, attrs|
      describe method.to_s do
        it 'returns true for warning time' do
          model.assign_attributes(attrs[:timepoint] => Time.current + attrs[:time])
          expect(model.public_send(method)).to be_truthy
        end

        it 'returns false for not warning time' do
          model.assign_attributes(attrs[:timepoint] => Time.current + attrs[:time] + 1.day)
          expect(model.public_send(method)).to be_falsy
        end
      end
    end
  end
end
