# frozen_string_literal: true

RSpec.describe Api::V1::Public::ProjectCompetitorsController do
  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, ProjectCompetitor
      post :create, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#destroy' do
    let(:project_competitor) { create(:project_competitor) }

    it 'cancan does not allow :destroy' do
      @ability.cannot :destroy, ProjectCompetitor
      delete :destroy, params: { format: :json, id: project_competitor.competitor_logo.id }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
