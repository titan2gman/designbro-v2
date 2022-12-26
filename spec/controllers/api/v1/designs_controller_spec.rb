# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DesignsController do
  let(:project) { create(:project) }

  let(:params) do
    {
      format: :json,
      project_id: project.id
    }
  end

  let(:show_params) do
    params.merge(id: create(:design, project: project).id)
  end

  context 'client' do
    let(:client) { create(:client) }

    before do
      request.headers.merge!(client.user.create_new_auth_token)
    end

    context '#index' do
      it 'cancan does not allow :read' do
        @ability.cannot :index, Design
        get :index, params: params

        expect(response).to have_http_status(:forbidden)
      end
    end

    context '#show' do
      it 'cancan does not allow :show' do
        @ability.cannot :show, Design
        get :show, params: show_params

        expect(response).to have_http_status(:forbidden)
      end
    end

    context '#update' do
      it 'cancan does not allow :update' do
        @ability.cannot :update, Design
        patch :update, params: show_params

        expect(response).to have_http_status(:forbidden)
      end
    end

    context '#restore' do
      it 'cancan does not allow :restore' do
        @ability.cannot :restore, Design
        patch :restore, params: show_params

        expect(response).to have_http_status(:forbidden)
      end
    end

    context '#eliminate' do
      it 'cancan does not allow :eliminate' do
        @ability.cannot :eliminate, Design
        patch :eliminate, params: show_params

        expect(response).to have_http_status(:forbidden)
      end
    end

    context '#block' do
      it 'cancan does not allow :block' do
        @ability.cannot :block, Design
        patch :block, params: show_params

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'designer' do
    let(:designer) { create(:designer) }

    before do
      request.headers.merge!(designer.user.create_new_auth_token)
    end

    context '#create' do
      it 'cancan does not allow :create' do
        @ability.cannot :create, Design
        create(:reserved_spot, project: project, designer: designer)
        post :create, params: params

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
