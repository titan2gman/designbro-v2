# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProjectWizardController, type: :controller do
  before do
    allow(Stripe::Charge).to receive(:create)
    allow(InvoiceJob).to receive(:perform_later)

    [:logo, :packaging, :brand_identity].each do |project_type|
      create(:"#{project_type}_project_price")
    end
  end

  describe 'PATCH #update' do
    describe 'details step' do
      [true, false].each do |upgrade_project_state|
        it 'responds with 200 (OK) and renders nothing (state: :waiting_for_details)' do
          project = attributes_for(:project).slice(
            :business_customer,
            :max_spots_count,
            :upgrade_package,
            :description,
            :discount,
            :name
          )

          project[:nda_type] = 'standard'
          project[:country_code] = 'UA'

          client = create(:client)

          client_project = create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

          request.headers.merge! client.user.create_new_auth_token

          patch :update, params: {
            upgrade_project_state: upgrade_project_state,
            project: project,
            step: :details,
            format: :json
          }

          expect(response.body).to eq('')
          expect(response).to have_http_status(:ok)
          expect(client_project.reload.state).to eq(
            if upgrade_project_state
              Project::STATE_WAITING_FOR_CHECKOUT.to_s
            else
              Project::STATE_WAITING_FOR_DETAILS.to_s
            end
          )
        end
      end

      [true, false].each do |upgrade_project_state|
        it 'responds with 200 (OK) and renders nothing (state: :waiting_for_checkout)' do
          project = attributes_for(:project).slice(
            :business_customer,
            :max_spots_count,
            :upgrade_package,
            :description,
            :name
          )

          project[:nda_type] = 'standard'
          project[:country_code] = 'UA'

          client = create(:client)
          client.user.state = :active

          create(:project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

          request.headers.merge! client.user.create_new_auth_token

          patch :update, params: {
            upgrade_project_state: upgrade_project_state,
            project: project,
            step: :details,
            format: :json
          }

          expect(response.body).to eq('')
          expect(response).to have_http_status(:ok)
        end
      end

      it 'responds with 401 (UNAUTHORIZED) and renders errors for guest' do
        patch :update, params: { step: :details, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'responds with 401 (UNAUTHORIZED) and renders errors for designer' do
        request.headers.merge! create(:designer).user.create_new_auth_token
        patch :update, params: { step: :details, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'responds with 404 (NOT FOUND) and renders nothing' do
        client = create(:client)
        client.user.state = :active

        request.headers.merge! client.user.create_new_auth_token
        patch :update, params: { step: :details, format: :json }

        expect(response.body).to eq ''
        expect(response).to have_http_status(:not_found)
      end

      it 'responds with 422 (UNPROCESSABLE ENTITY) and renders errors' do
        client = create(:client)
        client.user.state = :active

        create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

        project = { discount_code: create(:discount, begin_date: 1.hour.from_now).code }
        request.headers.merge! client.user.create_new_auth_token
        patch :update, params: {
          upgrade_project_state: true,
          project: project,
          step: :details,
          format: :json
        }

        expect(response).to have_http_status(:unprocessable_entity)
        response_schema = 'project_wizard/errors-details-step'
        expect(response).to match_response_schema(response_schema)
      end
    end

    describe 'checkout step' do
      ['logo', 'brand_identity', 'packaging'].each do |project_type|
        ['bank_transfer', 'pay_pal'].each do |payment_type|
          [true, false].each do |upgrade_project_state|
            [true, false].each do |business_customer|
              it "responds with 200 (OK) and renders nothing \
                  (business customer: #{business_customer}, \
                  upgrade_project_state: #{upgrade_project_state}, \
                  project_type: #{project_type}, \
                  payment_type: #{payment_type})" do
                attributes = attributes_for(:billing_address).merge(
                  business_customer: business_customer,
                  payment_type: payment_type
                )

                client = create(:client)
                client.user.state = :active

                client_project = create(
                  :project,
                  state: Project::STATE_WAITING_FOR_CHECKOUT,
                  project_type: project_type,
                  client: client
                )

                request.headers.merge! client.user.create_new_auth_token

                patch :update, params: {
                  upgrade_project_state: upgrade_project_state,
                  project: attributes,
                  step: :checkout,
                  format: :json
                }

                expect(response.body).to eq('')
                expect(response).to have_http_status(:ok)
                expect(client_project.reload.state).to eq(
                  if upgrade_project_state
                    if project_type == 'brand_identity'
                      if payment_type == 'bank_transfer'
                        Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS.to_s
                      else
                        Project::STATE_WAITING_FOR_STATIONERY_DETAILS.to_s
                      end
                    elsif payment_type == 'bank_transfer'
                      Project::STATE_WAITING_FOR_PAYMENT.to_s
                    else
                      Project::STATE_DESIGN_STAGE.to_s
                    end
                  else
                    Project::STATE_WAITING_FOR_CHECKOUT.to_s
                  end
                )
              end
            end
          end
        end
      end

      it 'responds with 422 (UNPROCESSABLE ENTITY) and renders errors' do
        client = create(:client)
        client.user.state = :active

        create(:project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

        project = { payment_type: :credit_card }

        request.headers.merge! client.user.create_new_auth_token

        patch :update, params: {
          upgrade_project_state: true,
          project: project,
          step: :checkout,
          format: :json
        }

        expect(response).to have_http_status(:unprocessable_entity)

        response_schema = 'project_wizard/errors-checkout-step'
        expect(response).to match_response_schema(response_schema)
      end

      it 'responds with 401 (UNAUTHORIZED) and renders errors for guest' do
        patch :update, params: { step: :checkout, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'responds with 401 (UNAUTHORIZED) and renders errors for designer' do
        request.headers.merge! create(:designer).user.create_new_auth_token
        patch :update, params: { step: :checkout, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'responds with 404 (NOT FOUND) and renders nothing' do
        client = create(:client)
        client.user.state = :active

        request.headers.merge! client.user.create_new_auth_token
        patch :update, params: { step: :details, format: :json }

        expect(response.body).to eq ''
        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'stationery step' do
      [true, false].each do |upgrade_project_state|
        it "responds with 200 (OK) and renders nothing (upgrade_project_state: #{upgrade_project_state})" do
          attributes = attributes_for(:project)

          client = create(:client)
          client.user.state = :active

          project = create(:project,
                           project_type: :brand_identity,
                           state: Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
                           client: client)
          create(:payment, project: project)

          request.headers.merge! client.user.create_new_auth_token

          patch :update, params: {
            upgrade_project_state: upgrade_project_state,
            project: attributes,
            step: :stationery,
            format: :json
          }

          expect(response.body).to eq('')
          expect(response).to have_http_status(:ok)
        end
      end

      it 'responds with 422 (UNPROCESSABLE ENTITY) and renders errors' do
        client = create(:client)
        client.user.state = :active

        create(:project, project_type: :logo, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

        request.headers.merge! client.user.create_new_auth_token

        patch :update, params: {
          upgrade_project_state: true,
          project: { abc: :def },
          step: :stationery,
          format: :json
        }

        expect(response).to have_http_status(:unprocessable_entity)

        response_schema = 'project_wizard/errors-stationery-step'
        expect(response).to match_response_schema(response_schema)
      end

      it 'responds with 401 (UNAUTHORIZED) and renders errors for guest' do
        patch :update, params: { step: :stationery, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'responds with 401 (UNAUTHORIZED) and renders errors for designer' do
        request.headers.merge! create(:designer).user.create_new_auth_token
        patch :update, params: { step: :stationery, format: :json }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'responds with 404 (NOT FOUND) and renders nothing' do
        client = create(:client)
        client.user.state = :active

        request.headers.merge! client.user.create_new_auth_token
        patch :update, params: { step: :stationery, format: :json }

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq ''
      end
    end
  end
end
