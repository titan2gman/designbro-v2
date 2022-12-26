# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectColor do
  describe 'associations' do
    it { is_expected.to belong_to :project }
  end

  describe 'validations' do
    it { should validate_presence_of :hex }
    it { should validate_presence_of :project }
  end
end
