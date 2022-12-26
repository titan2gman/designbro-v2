# frozen_string_literal: true

RSpec.describe AbandonedCartDiscount do
  describe 'validations' do
    it { should belong_to(:discount).optional }
  end
end
