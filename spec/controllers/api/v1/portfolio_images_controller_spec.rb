# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PortfolioImagesController do
  let(:client) { create(:client) }

  before do
    request.headers.merge!(client.user.create_new_auth_token)

    portfolio_list = create(:portfolio_list, list_type: :summary)
    portfolio_image = create(:portfolio_image)
    portfolio_list.portfolio_images << portfolio_image
  end

  context '#index' do
    it 'cancan does not allow :read' do
      @ability.cannot :read, PortfolioImage
      get :index, params: { portfolio_list: { list_type: :summary }, format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
