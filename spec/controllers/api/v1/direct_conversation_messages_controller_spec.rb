# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DirectConversationMessagesController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#index' do
    let(:project) { create(:project) }
    let(:design) { create(:design, project: project) }
    let(:params) do
      {
        format: :json,
        project_id: project.id,
        design_id: design.id
      }
    end

    it 'cancan does not allow :read' do
      @ability.cannot :read, DirectConversationMessage
      get :index, params: params

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#create' do
    let(:project) { create(:project) }
    let(:design)  { create(:design, project: project) }
    let(:params) do
      {
        format: :json,
        project_id: project.id,
        design_id: design.id,
        direct_conversation_message: attributes_for(:direct_conversation_message)
      }
    end

    it 'cancan does not allow :create' do
      @ability.cannot :create, DirectConversationMessage
      post :create, params: params

      expect(response).to have_http_status(:forbidden)
    end
  end
end
