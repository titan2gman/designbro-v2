# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'transactionable' do |property|
  let(:factory) { described_class.to_s.underscore }

  describe 'persisted' do
    subject { create(factory).public_send property }

    it { is_expected.not_to be_nil }
  end

  describe 'not persisted' do
    subject { build(factory).public_send property }

    it { is_expected.to be_nil }
  end
end
