# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FaqGroup do
  describe 'associations' do
    it { should have_many(:faq_items).dependent :destroy }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end
end
