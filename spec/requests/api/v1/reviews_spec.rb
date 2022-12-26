# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Review API' do
  describe 'guest' do
    describe 'GET /api/v1/reviews' do
      it 'responds with 401 (UNAUTHORIZED)' do
        get api_v1_reviews_path

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'POST /api/v1/reviews' do
      it 'responds with 401 (UNAUTHORIZED)' do
        post api_v1_reviews_path

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'designer' do
    describe 'GET /api/v1/reviews' do
      it 'responds with 401 (UNAUTHORIZED)' do
        designer = create(:designer)

        headers = designer.user.create_new_auth_token
        get api_v1_reviews_path, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'POST /api/v1/reviews' do
      it 'responds with 401 (UNAUTHORIZED)' do
        designer = create(:designer)

        headers = designer.user.create_new_auth_token
        post api_v1_reviews_path, headers: headers

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'client' do
    describe 'GET /api/v1/reviews' do
      it 'responds with 200 (OK)' do
        client   = create(:client)
        designer = create(:designer)
        design   = create(:design, designer: designer)

        create(:review, client: client, design: design)

        headers = client.user.create_new_auth_token
        get api_v1_reviews_path, headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('reviews/index')
      end
    end

    describe 'POST /api/v1/reviews' do
      it 'responds with 201 (CREATED)' do
        design = create(:winner_design)
        client = design.project.client

        review = attributes_for(:review)
                 .merge(design_id: design.id)

        params = { review: review }
        headers = client.user.create_new_auth_token

        post api_v1_reviews_path, headers: headers, params: params

        expect(response).to have_http_status(:created)
        expect(response).to match_response_schema('reviews/create')
      end

      it 'responds with 403 (Forbidden)' do
        client = create(:client)
        design = create(:design)

        review = attributes_for(:review)
                 .merge(design_id: design.id)

        params = { review: review }
        headers = client.user.create_new_auth_token

        post api_v1_reviews_path, headers: headers, params: params

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
