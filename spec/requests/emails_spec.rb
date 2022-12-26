# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Emails' do
  describe 'GET /emails/abandoned_cart/unsubscribe' do
    let(:project) { create(:project) }

    describe 'invalid token' do
      let(:token) { 'invalid_token' }
      let(:expected_url) { "#{ENV.fetch('ROOT_URL')}/errors/404" }

      it 'redirects_to url expired page' do
        get "/emails/abandoned_cart/unsubscribe?token=#{token}"

        expect(response).to redirect_to(expected_url)
      end
    end

    describe 'valid token' do
      let(:project_params) { { projectName: project.name } }
      let(:secret_key) { Rails.application.secrets.secret_key_base[0, 32] }
      let(:token) { ActiveSupport::MessageEncryptor.new(secret_key).encrypt_and_sign(project.id) }
      let(:expected_url) { "#{ENV.fetch('ROOT_URL')}/emails/abandoned-cart/unsubscribe?#{project_params.to_query}" }

      it 'redirects to emails/abandoned-cart/unsubscribe with project name' do
        get "/emails/abandoned_cart/unsubscribe?token=#{token}"

        expect(response).to redirect_to(expected_url)
      end
    end
  end
end
