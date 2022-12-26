# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectBrandExample do
  describe 'associations' do
    it { should belong_to :project }
    it { should belong_to :brand_example }
  end

  describe 'validations' do
    it { should validate_presence_of :brand_example }
    it { should validate_presence_of :example_type }
    it { should validate_presence_of :project }
  end
end
