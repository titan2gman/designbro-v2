# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Testimonials API' do
  describe 'GET /api/v1/public/testimonial' do
    describe 'client' do
      let(:user) { create(:client).user }

      it 'responds with 200 (OK) and renders testimonial' do
        create(:testimonial)

        headers = user.create_new_auth_token
        get api_v1_public_testimonial_path, headers: headers

        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('testimonials/show')
      end

      it 'returns status 404 if there are no testimonials' do
        headers = user.create_new_auth_token
        get api_v1_public_testimonial_path, headers: headers

        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'designer' do
      let(:user) { create(:designer).user }

      it 'responds with 403 (FORBIDDEN)' do
        create(:testimonial)

        headers = user.create_new_auth_token
        get api_v1_public_testimonial_path, headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'guest' do
      it 'responds with 403 (FORBIDDEN)' do
        create(:testimonial)

        get api_v1_public_testimonial_path

        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'god client' do
      let(:user) { create(:god_client).user }

      it 'responds with 200 (OK) and renders testimonial' do
        create(:testimonial)

        headers = user.create_new_auth_token
        get api_v1_public_testimonial_path, headers: headers

        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('testimonials/show')
      end

      it 'returns status 404 if there are no testimonials' do
        headers = user.create_new_auth_token
        get api_v1_public_testimonial_path, headers: headers

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
