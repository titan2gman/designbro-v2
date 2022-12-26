# frozen_string_literal: true

RSpec.describe AbandonedCartReminder do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:step) }
    it { should validate_presence_of(:minutes_to_reminder) }
    it { should validate_numericality_of(:step).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:minutes_to_reminder).is_greater_than_or_equal_to(1) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_inclusion_of(:name).in_array(Project::REMINDER_ACTIVE_STATES) }
  end
end
