# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Receipts' do
  describe 'GET /receipts/:project_id' do
    describe 'with auth headers' do
      describe 'designer' do
        it 'responds with 401 and renders nothing' do
          designer = create(:designer)

          get '/receipts/1', params: designer.user.create_new_auth_token

          expect(response.body).to eq('')
          expect(response).to have_http_status(:unauthorized)
        end
      end

      describe 'client' do
        describe 'invalid project id' do
          it 'responds with 404 and renders nothing' do
            headers = create(:client).user.create_new_auth_token

            get '/receipts/123', params: headers

            expect(response.body).to eq('')
            expect(response).to have_http_status(:not_found)
          end
        end

        describe 'valid project id' do
          describe 'valid project state' do
            it 'responds with 200 and renders receipts' do
              project = create(:logo_project, state: Project::STATE_DESIGN_STAGE)
              create(:eu_billing_address, project: project)
              create(:payment, project: project)
              create(:united_kingdom_vat_rate)
              create(:logo_project_price)

              headers = project.client.user.create_new_auth_token

              get "/receipts/#{project.id}", params: headers

              expect(response.body).not_to eq('')
              expect(response).to have_http_status(:ok)
            end
          end

          describe 'invalid project state' do
            it 'responds with 404 and renders nothing' do
              project = create(:logo_project, state: Project::STATE_WAITING_FOR_CHECKOUT)
              create(:eu_billing_address, project: project)
              create(:payment, project: project)
              create(:united_kingdom_vat_rate)
              create(:logo_project_price)

              headers = project.client.user.create_new_auth_token

              get "/receipts/#{project.id}", params: headers

              expect(response.body).to eq('')
              expect(response).to have_http_status(:not_found)
            end
          end
        end
      end
    end

    describe 'without auth headers' do
      it 'responds with 401 and renders nothing' do
        get '/receipts/1'
        expect(response.body).to eq('')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
