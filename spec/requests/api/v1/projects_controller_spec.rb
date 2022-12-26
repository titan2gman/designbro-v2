# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do
  describe 'GET /project' do
    describe 'guest' do
      [
        Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
        Project::STATE_WAITING_FOR_FINISH_DETAILS,
        Project::STATE_WAITING_FOR_STYLE_DETAILS,
        Project::STATE_DRAFT
      ].map(&:to_s).each do |state|
        it "responds with 200 (OK) and renders project (state: #{state})" do
          project = create(:project, state: state, client: nil)
          cookies.encrypted[:project_id] = project.id

          get :show, format: :json

          expect(response).to have_http_status(:ok)
          expect(response).to match_response_schema('projects/show')
        end
      end

      it 'responds with 404 (NOT FOUND) if there is no data about project in cookies' do
        get :show, format: :json

        expect(response.body).to eq('')
        expect(response).to have_http_status(:not_found)
      end

      [
        Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS,
        Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
        Project::STATE_WAITING_FOR_CHECKOUT,
        Project::STATE_WAITING_FOR_PAYMENT,
        Project::STATE_WAITING_FOR_DETAILS,
        Project::STATE_FINALIST_STAGE,
        Project::STATE_DESIGN_STAGE,
        Project::STATE_REVIEW_FILES,
        Project::STATE_FILES_STAGE,
        Project::STATE_COMPLETED,
        Project::STATE_CANCELED,
        Project::STATE_ERROR
      ].map(&:to_s).each do |state|
        it "responds with 404 (NOT FOUND) if project has state '#{state}'" do
          cookies.encrypted[:project_id] = create(:project, state: state).id

          get :show, format: :json

          expect(response.body).to eq('')
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'for client' do
      it 'responds with 200 (OK) and renders project from cookies if there is data about project in cookies' do
        project = create(:project)
        client = project.client

        cookies.encrypted[:project_id] = project.id

        headers = client.user.create_new_auth_token
        request.headers.merge! headers
        get :show, format: :json

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/show')
      end

      it 'responds with 200 (OK) and renders project from DB if there is no data about project in cookies' do
        client = create(:project).client

        headers = client.user.create_new_auth_token
        request.headers.merge! headers
        get :show, format: :json

        expect(response).to have_http_status(:ok)
        expect(response.cookies['project_id']).to be_nil
        expect(response).to match_response_schema('projects/show')
      end

      it 'responds with 404 (NOT FOUND) if there is no data about project in cookies and DB' do
        client = create(:client)

        headers = client.user.create_new_auth_token
        request.headers.merge! headers
        get :show, format: :json

        expect(response.body).to eq('')
        expect(response.cookies['project_id']).to be_nil
        expect(response).to have_http_status(:not_found)
      end

      [
        Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
        Project::STATE_WAITING_FOR_FINISH_DETAILS,
        Project::STATE_WAITING_FOR_STYLE_DETAILS,
        Project::STATE_WAITING_FOR_CHECKOUT,
        Project::STATE_WAITING_FOR_DETAILS,
        Project::STATE_DRAFT
      ].map(&:to_s).each do |state|
        it "responds with 200 (OK) and renders project (state: #{state})" do
          project = create(:project, state: state)
          cookies.encrypted[:project_id] = project.id

          headers = project.client.user.create_new_auth_token
          request.headers.merge! headers

          get :show, format: :json

          expect(response).to have_http_status(:ok)
          expect(response).to match_response_schema('projects/show')
        end
      end

      [
        Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS,
        Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
        Project::STATE_WAITING_FOR_PAYMENT,
        Project::STATE_FINALIST_STAGE,
        Project::STATE_DESIGN_STAGE,
        Project::STATE_REVIEW_FILES,
        Project::STATE_FILES_STAGE,
        Project::STATE_COMPLETED,
        Project::STATE_CANCELED,
        Project::STATE_ERROR
      ].map(&:to_s).each do |state|
        it "responds with 200 (OK) and renders project (state: #{state})" do
          project = create(:project, state: state)
          cookies.encrypted[:project_id] = project.id

          get :show, format: :json

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe 'DELETE /project' do
    it 'responds with 200(OK)' do
      project = create(:project)
      cookies.encrypted[:project_id] = project.id

      headers = project.client.user.create_new_auth_token
      request.headers.merge! headers

      delete :destroy, format: :json

      expect(response).to have_http_status(:ok)
    end
  end
end
