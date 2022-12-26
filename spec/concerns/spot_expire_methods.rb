# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'spot expire methods' do
  it_should_behave_like 'time methods'

  describe 'expired' do
    {
      reservation_expired?: { timepoint: :reserved_state_started_at, const: '_RESERVATION_EXPIRE_TIME' }
    }.each do |method, attrs|
      describe method.to_s do
        [:logo, :brand_identity, :packaging].each do |project_type|
          let(:project) { create(:project, project_type: project_type) }
          let(:model) { described_class.new(project: project) }
          let(:const) { project_type.upcase.to_s + attrs[:const] }

          it 'returns true for expired' do
            model.assign_attributes(attrs[:timepoint] => (model.class.const_get(const) + 1).ago)
            expect(model.public_send(method)).to be_truthy

            model.assign_attributes(attrs[:timepoint] => model.class.const_get(const).ago)
            expect(model.public_send(method)).to be_truthy
          end

          it 'returns false for not expired' do
            model.assign_attributes(attrs[:timepoint] => (model.class.const_get(const) - 1).ago)
            expect(model.public_send(method)).to be_falsey
          end
        end
      end
    end
  end

  describe 'warnings' do
    {
      send_12_hours_of_reservation_left_warning?: { timepoint: :reserved_state_started_at, const: '_RESERVATION_EXPIRE_TIME', time: 12.hours }
    }.each do |method, attrs|
      describe method.to_s do
        [:logo, :brand_identity, :packaging].each do |project_type|
          let(:project) { create(:project, project_type: project_type) }
          let(:model) { described_class.new(project: project) }
          let(:const) { project_type.upcase.to_s + attrs[:const] }

          it 'returns true for warning time' do
            model.assign_attributes(attrs[:timepoint] => (model.class.const_get(const) - attrs[:time]).ago)
            expect(model.public_send(method)).to be_truthy
          end

          it 'returns false for not warning time' do
            model.assign_attributes(attrs[:timepoint] => (model.class.const_get(const) - attrs[:time] - 1).ago)
            expect(model.public_send(method)).to be_falsy
          end
        end
      end
    end
  end
end
