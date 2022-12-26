# frozen_string_literal: true

RSpec.describe Emails::AbandonedCarts::Unsubscribe do
  subject { described_class.new(token) }

  let(:project) { create(:project) }
  let(:root_url) { 'http://some-root-url' }
  let(:project_params) { { projectName: project.name } }
  let(:token) do
    ActiveSupport::MessageEncryptor.new(secret_key).encrypt_and_sign(project.id)
  end
  let(:secret_key) { Rails.application.secrets.secret_key_base[0, 32] }

  before do
    allow(ENV).to receive(:fetch).with('ROOT_URL') { root_url }
  end

  describe 'returns unsubscribe abandoned cart emails url' do
    let(:expected_redirect_url) { "#{ENV.fetch('ROOT_URL')}/emails/abandoned-cart/unsubscribe?#{project_params.to_query}" }
    let(:client) { project.client }

    it do
      expect(client.opt_out).to be_falsey
      expect(subject.call).to eq expected_redirect_url
      expect(client.reload.opt_out).to be_truthy
    end
  end

  describe 'project blank' do
    let(:token) { 'some_invalid_token' }

    it do
      expect(subject.call).to match(%r{#{root_url}\/errors\/404})
    end
  end
end
