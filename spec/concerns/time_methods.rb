# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'time methods' do
  let(:model) { described_class.new }

  describe '#time_from' do
    it { expect(model.time_from(1.day.ago)).to eq(1.day) }
  end
end
