# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::VatRatesController do
  context '#index' do
    it 'cancan does not allow :read' do
      @ability.cannot :read, VatRate
      get :index, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
