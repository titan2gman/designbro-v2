# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FaqItem do
  describe 'associations' do
    it { should belong_to :faq_group }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :answer }
  end
end
