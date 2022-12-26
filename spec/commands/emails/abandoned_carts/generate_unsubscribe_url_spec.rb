# frozen_string_literal: true

RSpec.describe Emails::AbandonedCarts::GenerateUnsubscribeUrl do
  subject { described_class.new(project) }

  let(:project) { create(:project) }
  let(:root_url) { 'http://some-root-url' }

  before do
    allow(ENV).to receive(:fetch).with('ROOT_URL') { root_url }
  end

  describe 'returns unsubscribe abandoned cart emails url' do
    it do
      expect(subject.call).to match(%r{#{root_url}\/emails\/abandoned_cart\/unsubscribe\?token=[a-zA-Z0-9=\-%]{110}})
    end
  end

  describe 'returns nil if project blank' do
    describe 'project blank' do
      let(:project) { nil }

      it do
        expect(subject.call).to be_nil
      end
    end
  end
end
