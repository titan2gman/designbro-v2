# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::TestimonialsController do
  context '#show' do
    it 'cancan does not allow :read' do
      create(:testimonial)
      @ability.cannot :read, Testimonial
      get :show, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
