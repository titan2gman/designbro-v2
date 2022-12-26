# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::NdaPricesController do
  context '#index' do
    it 'cancan does not allow :index' do
      @ability.cannot :read, NdaPrice
      get :index, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
