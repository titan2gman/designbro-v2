# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FaqItemsController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#show' do
    let(:faq_item) { create(:faq_item) }

    it 'cancan does not allow :read' do
      @ability.cannot :read, FaqItem
      get :show, params: { format: :json, id: faq_item.id }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
