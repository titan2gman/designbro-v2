# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'portfolio images API' do
  describe 'GET /api/v1/portfolio_images' do
    context 'guest' do
      before do
        @portfolio_list = create(:portfolio_list, list_type: :summary)
        @portfolio_image = create(:portfolio_image)
        create(:portfolio_image)

        @portfolio_list.portfolio_images << @portfolio_image
      end

      after do
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('portfolio_images/index')
      end

      it 'responds with 200 (OK) and returns portfolio_images of one portfolio list' do
        get api_v1_portfolio_images_path(portfolio_list: { list_type: @portfolio_list.list_type })
      end

      it 'responds with 200 (OK) and returns all portfolio_images' do
        get api_v1_portfolio_images_path
      end
    end

    context 'client' do
      before do
        @client = create(:client)
        @portfolio_list = create(:portfolio_list, list_type: :summary)
        @portfolio_image = create(:portfolio_image)
        create(:portfolio_image)

        @portfolio_list.portfolio_images << @portfolio_image

        @headers = @client.user.create_new_auth_token
      end

      after do
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema('portfolio_images/index')
      end

      it 'responds with 200 (OK) and returns portfolio_images of one portfolio list' do
        get api_v1_portfolio_images_path(portfolio_list: { list_type: @portfolio_list.list_type }), headers: @headers
      end

      it 'responds with 200 (OK) and returns all portfolio_images' do
        get api_v1_portfolio_images_path
      end
    end

    context 'designer' do
      it 'response with 403 (forbidden)' do
        create(:portfolio_image)
        headers = create(:designer).user.create_new_auth_token

        get api_v1_portfolio_images_path, headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
