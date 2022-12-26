# frozen_string_literal: true

RSpec.describe Deeplinks::ProjectBrief::GenerateRedirectUrl do
  subject { described_class.new(client) }

  let(:client) { create(:client) }
  let(:root_url) { 'http://some-root-url' }

  before do
    allow(ENV).to receive(:fetch).with('ROOT_URL') { root_url }
  end

  describe 'returns continue brief deeplink url' do
    let(:expected_url) { "#{root_url}#{described_class::CONTINUE_BRIEF_URL}" }

    it 'returns continue brief redirect url if client present' do
      expect(subject.call).to eq expected_url
      expect(subject.token).to be_present
      expect(subject.client_id).to be_present
      expect(subject.uid).to be_present
      expect(subject.redirect_url).to eq expected_url
    end
  end

  describe 'returns expired deeplink url ' do
    let(:expected_url) { "#{root_url}#{described_class::EXPIRED_REDIRECT_URL}" }

    describe 'client blank' do
      let(:client) { nil }

      it 'returns expired redirect url if client blank' do
        expect(subject.call).to eq expected_url
        expect(subject.token).to be_blank
        expect(subject.client_id).to be_blank
        expect(subject.uid).to be_blank
        expect(subject.redirect_url).to eq expected_url
      end
    end
  end
end
