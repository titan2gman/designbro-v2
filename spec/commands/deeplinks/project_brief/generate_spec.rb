# frozen_string_literal: true

RSpec.describe Deeplinks::ProjectBrief::Generate do
  subject { described_class.new(client) }

  let(:client) { create(:client) }
  let(:root_url) { 'http://some-root-url' }

  before do
    allow(ENV).to receive(:fetch).with('ROOT_URL') { root_url }
  end

  describe 'returns continue brief deeplink url' do
    it do
      expect(subject.call).to match(%r{#{root_url}\/continue_brief\?token=[a-zA-Z0-9_\-.]{108}})
    end
  end

  describe 'returns nil if client blank' do
    describe 'client blank' do
      let(:client) { nil }

      it do
        expect(subject.call).to be_nil
      end
    end
  end
end
