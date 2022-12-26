# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :subject }
    it { should validate_presence_of :message }
  end
end
