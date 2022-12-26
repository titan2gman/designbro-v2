# frozen_string_literal: true

RSpec.describe Testimonial do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:header) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_presence_of(:credential) }
    it { is_expected.to validate_presence_of(:company) }
    it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:rating).is_less_than_or_equal_to(5) }
  end
end
