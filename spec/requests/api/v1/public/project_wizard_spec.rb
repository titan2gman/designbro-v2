# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::ProjectWizardController, type: :controller do
  describe 'POST /project' do
    describe 'for guest' do
      describe 'responds with 201 (CREATED) and renders created project' do
        ['logo', 'brand_identity', 'packaging'].each do |project_type|
          scenario project_type do
            project = { project_type: project_type }

            post :create, params: {
              project: project,
              format: :json
            }

            expect(response.body).to eq('')
            expect(response).to have_http_status(:created)
            expect(response.cookies['project_id']).not_to be_nil
          end
        end
      end
    end

    describe 'for client' do
      describe 'responds with 201 (CREATED) and renders created project' do
        ['logo', 'brand_identity', 'packaging'].each do |project_type|
          scenario project_type do
            client = create(:client)

            project = { project_type: project_type }

            headers = client.user.create_new_auth_token
            params = { project: project, format: :json }

            request.headers.merge! headers
            post :create, params: params

            expect(response.body).to eq('')
            expect(response).to have_http_status(:created)
            expect(response.cookies['project_id']).to be_nil
          end
        end
      end
    end
  end

  describe 'PATCH /project/examples' do
    describe 'for guest' do
      it 'responds with 200 (OK) and renders updated project' do
        good_brand_examples_ids = create_list(:brand_example, 6).map(&:id)
        skip_brand_example_id = create(:brand_example).id
        bad_brand_example_id = create(:brand_example).id

        project = { skip_examples: [skip_brand_example_id],
                    good_examples: good_brand_examples_ids,
                    bad_examples: [bad_brand_example_id] }

        cookies.encrypted[:project_id] = create(:project, client: nil).id

        patch :update, params: {
          upgrade_project_state: true,
          project: project,
          step: :examples,
          format: :json
        }

        expect(response.body).to eq('')
        expect(response).to have_http_status(:ok)
      end

      it 'responds with 422 (UNPROCESSABLE ENTITY) if no data about examples was passed' do
        cookies.encrypted[:project_id] = create(:project, client: nil).id

        patch :update, params: {
          upgrade_project_state: true,
          project: { abc: :def },
          step: :examples,
          format: :json
        }

        expect(response).to match_response_schema('project_wizard/errors-examples-step')
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'responds with 404 (NOT FOUND) if project token was not specified' do
        patch :update, params: { step: :examples, format: :json }

        expect(response).to have_http_status(:not_found)
      end

      it 'responds with 404 (NOT FOUND) if invalid project token was specified' do
        cookies.encrypted[:project_id] = '123'

        patch :update, params: { step: :examples, format: :json }

        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'for client' do
      it 'responds with 200 (OK) and renders updated project' do
        good_brand_examples_ids = create_list(:brand_example, 6).map(&:id)
        skip_brand_example_id = create(:brand_example).id
        bad_brand_example_id = create(:brand_example).id

        project = attributes_for(:project).merge(
          good_examples: good_brand_examples_ids,
          skip_examples: [skip_brand_example_id],
          bad_examples: [bad_brand_example_id]
        )

        cookies.encrypted[:project_id] = create(:project, client: nil).id

        client = create(:client)
        request.headers.merge! client.user.create_new_auth_token
        cookies.encrypted[:project_id] = create(:project, client: client).id
        patch :update, params: {
          upgrade_project_state: true,
          project: project,
          step: :examples,
          format: :json
        }

        expect(response).to have_http_status(:ok)
      end

      it 'responds with 422 (UNPROCESSABLE ENTITY) if no data about examples was passed' do
        client = create(:client)
        request.headers.merge! client.user.create_new_auth_token
        cookies.encrypted[:project_id] = create(:project, client: client).id

        patch :update, params: {
          upgrade_project_state: true,
          project: { abc: :def },
          step: :examples,
          format: :json
        }

        expect(response).to match_response_schema('project_wizard/errors-examples-step')
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'responds with 404 (NOT FOUND) if project token was not specified' do
        request.headers.merge! create(:client).user.create_new_auth_token
        patch :update, params: { step: :examples, format: :json }
        expect(response).to have_http_status(:not_found)
      end

      it 'responds with 404 (NOT FOUND) if invalid project token was specified' do
        cookies.encrypted[:project_id] = '123'

        request.headers.merge! create(:client).user.create_new_auth_token
        patch :update, params: { step: :examples, format: :json }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PATCH /project/style' do
    [
      Project::STATE_WAITING_FOR_DETAILS,
      Project::STATE_WAITING_FOR_CHECKOUT,
      Project::STATE_WAITING_FOR_STYLE_DETAILS,
      Project::STATE_WAITING_FOR_FINISH_DETAILS,
      Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
      Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
      Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS
    ].map(&:to_s).each do |state|
      it "responds with 200 (OK) for project with state: #{state}" do
        project = attributes_for(:project)

        cookies.encrypted[:project_id] = create(:project, state: state, client: nil).id

        patch :update, params: {
          upgrade_project_state: true,
          project: project,
          format: :json,
          step: :style
        }

        expect(response).to have_http_status(:ok)
      end
    end

    [
      Project::STATE_ERROR,
      Project::STATE_CANCELED,
      Project::STATE_FILES_STAGE,
      Project::STATE_DESIGN_STAGE,
      Project::STATE_REVIEW_FILES,
      Project::STATE_FINALIST_STAGE
    ].map(&:to_s).each do |state|
      it "responds with 404 (Not found) for project with state: #{state}" do
        project = attributes_for(:project)

        cookies.encrypted[:project_id] = create(:project, state: state, client: nil).id

        patch :update, params: {
          upgrade_project_state: true,
          project: project,
          format: :json,
          step: :style
        }

        expect(response).to have_http_status(:not_found)
      end
    end

    it 'responds with 422 (UNPROCESSABLE ENTITY) if no style params was passed' do
      cookies.encrypted[:project_id] = create(:project, client: nil).id

      patch :update, params: {
        upgrade_project_state: true,
        project: { abc: :def },
        format: :json,
        step: :style
      }

      expect(response).to match_response_schema('project_wizard/errors-style-step')
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'responds with 404 (NOT FOUND) if project token was not specified' do
      patch :update, params: { step: :style, format: :json }

      expect(response).to have_http_status(:not_found)
    end

    it 'responds with 404 (NOT FOUND) if invalid project token was specified' do
      cookies.encrypted[:project_id] = '123'

      patch :update, params: { step: :style, format: :json }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PATCH /project/audience' do
    [
      Project::STATE_WAITING_FOR_DETAILS,
      Project::STATE_WAITING_FOR_CHECKOUT,
      Project::STATE_WAITING_FOR_STYLE_DETAILS,
      Project::STATE_WAITING_FOR_FINISH_DETAILS,
      Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
      Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
      Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS
    ].map(&:to_s).each do |state|
      it "responds with 200 (OK) for project with state #{state}" do
        project = attributes_for(:project)

        cookies.encrypted[:project_id] = create(:project, state: state, client: nil).id

        patch :update, params: {
          upgrade_project_state: true,
          project: project,
          step: :audience,
          format: :json
        }

        expect(response).to have_http_status(:ok)
      end
    end

    it 'responds with 422 (UNPROCESSABLE ENTITY) if no audience params was passed' do
      cookies.encrypted[:project_id] = create(:project, client: nil).id

      patch :update, params: {
        upgrade_project_state: true,
        project: { abc: :def },
        step: :audience,
        format: :json
      }

      expect(response).to match_response_schema('project_wizard/errors-audience-step')
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'responds with 404 (NOT FOUND) if project token was not specified' do
      patch :update, params: { step: :audience, format: :json }

      expect(response).to have_http_status(:not_found)
    end

    it 'responds with 404 (NOT FOUND) if invalid project token was specified' do
      cookies.encrypted[:project_id] = '123'

      patch :update, params: { step: :audience, format: :json }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PATCH /project/finish_logo' do
    [true, false].each do |upgrade_project_state|
      [
        Project::STATE_WAITING_FOR_DETAILS,
        Project::STATE_WAITING_FOR_CHECKOUT,
        Project::STATE_WAITING_FOR_STYLE_DETAILS,
        Project::STATE_WAITING_FOR_FINISH_DETAILS,
        Project::STATE_WAITING_FOR_AUDIENCE_DETAILS,
        Project::STATE_WAITING_FOR_STATIONERY_DETAILS,
        Project::STATE_WAITING_FOR_PAYMENT_AND_STATIONERY_DETAILS
      ].map(&:to_s).each do |state|
        it "responds with 200 (OK) for project with state: #{state} and renders updated project (upgrade_project_state: #{upgrade_project_state})" do
          project = create(:project, state: state)

          project_competitor = create(:project_competitor, project: project)
          project_inspiration = create(:project_inspiration, project: project)

          inspiration = attributes_for(:project_inspiration).merge(
            id: project_inspiration.inspiration_image.id
          )

          competitor = attributes_for(:project_competitor).merge(
            id: project_competitor.competitor_logo.id
          )

          attributes = attributes_for(:project).merge(
            inspirations: [inspiration],
            competitors: [competitor]
          )

          cookies.encrypted[:project_id] = project.id

          request.headers.merge! project.client.user.create_new_auth_token

          patch :update, params: {
            upgrade_project_state: upgrade_project_state,
            project: attributes,
            step: :finish_logo,
            format: :json
          }

          expect(response).to have_http_status(:ok)

          if state == Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
            expect(project.reload.state).to eq(
              if upgrade_project_state
                Project::STATE_WAITING_FOR_DETAILS.to_s
              else
                Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
              end
            )
          end
        end
      end
    end

    it 'responds with 200 (OK) and renders updated project but not updated state' do
      project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)

      project_competitor = create(:project_competitor, project: project)
      project_inspiration = create(:project_inspiration, project: project)

      inspiration = attributes_for(:project_inspiration).merge(
        id: project_inspiration.inspiration_image.id
      )

      competitor = attributes_for(:project_competitor).merge(
        id: project_competitor.competitor_logo.id
      )

      attributes = attributes_for(:project).merge(
        inspirations: [inspiration],
        competitors: [competitor]
      )

      cookies.encrypted[:project_id] = project.id

      patch :update, params: {
        upgrade_project_state: true,
        project: attributes,
        step: :finish_logo,
        format: :json
      }

      expect(response).to have_http_status(:ok)
      expect(project.reload.state).to eq(Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s)
    end

    it 'responds with 422 (UNPROCESSABLE ENTITY) if no audience params was passed' do
      project = create(:project)
      cookies.encrypted[:project_id] = project.id

      request.headers.merge! project.client.user.create_new_auth_token

      patch :update, params: {
        upgrade_project_state: true,
        project: { abc: :def },
        step: :finish_logo,
        format: :json
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to match_response_schema('project_wizard/errors-finish-logo-step')
    end

    it 'responds with 404 (NOT FOUND) if project token was not specified' do
      patch :update, params: { step: :finish_logo, format: :json }

      expect(response).to have_http_status(:not_found)
    end

    it 'responds with 404 (NOT FOUND) if invalid project token was specified' do
      cookies.encrypted[:project_id] = '123'

      patch :update, params: { step: :finish_logo, format: :json }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PATCH /project/finish_packaging' do
    [true, false].each do |upgrade_project_state|
      it 'responds with 200 (OK) and renders updated project' do
        project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS)

        project_competitor = create(:project_competitor, project: project)
        project_inspiration = create(:project_inspiration, project: project)
        project_additional_document = create(:project_additional_document, project: project)

        inspiration = attributes_for(:project_inspiration).merge(
          id: project_inspiration.inspiration_image.id
        )

        competitor = attributes_for(:project_competitor).merge(
          id: project_competitor.competitor_logo.id
        )

        additional_document = attributes_for(:project_additional_document).merge(
          id: project_additional_document.additional_document.id
        )

        attributes = attributes_for(:project).merge(
          additional_documents: [additional_document],
          inspirations: [inspiration],
          competitors: [competitor]
        )

        cookies.encrypted[:project_id] = project.id

        request.headers.merge! project.client.user.create_new_auth_token

        patch :update, params: {
          upgrade_project_state: upgrade_project_state,
          step: :finish_packaging,
          project: attributes,
          format: :json
        }

        expect(response).to have_http_status(:ok)
        expect(project.reload.state).to eq(
          if upgrade_project_state
            Project::STATE_WAITING_FOR_DETAILS.to_s
          else
            Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s
          end
        )
      end
    end

    it 'responds with 200 (OK) and renders updated project but not updated project state' do
      project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)

      project_competitor = create(:project_competitor, project: project)
      project_inspiration = create(:project_inspiration, project: project)
      project_additional_document = create(:project_additional_document, project: project)

      inspiration = attributes_for(:project_inspiration).merge(
        id: project_inspiration.inspiration_image.id
      )

      competitor = attributes_for(:project_competitor).merge(
        id: project_competitor.competitor_logo.id
      )

      additional_document = attributes_for(:project_additional_document).merge(
        id: project_additional_document.additional_document.id
      )

      attributes = attributes_for(:project).merge(
        additional_documents: [additional_document],
        inspirations: [inspiration],
        competitors: [competitor]
      )

      cookies.encrypted[:project_id] = project.id

      patch :update, params: {
        upgrade_project_state: true,
        step: :finish_packaging,
        project: attributes,
        format: :json
      }

      expect(response).to have_http_status(:ok)
      expect(project.reload.state).to eq(Project::STATE_WAITING_FOR_FINISH_DETAILS.to_s)
    end

    it 'responds with 422 (UNPROCESSABLE ENTITY) if no audience params was passed' do
      project = create(:project)
      cookies.encrypted[:project_id] = project.id

      request.headers.merge! project.client.user.create_new_auth_token

      patch :update, params: {
        step: :finish_packaging,
        upgrade_project_state: true,
        project: { abc: :def },
        format: :json
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to match_response_schema('project_wizard/errors-finish-packaging-step')
    end

    it 'responds with 404 (NOT FOUND) if project token was not specified' do
      patch :update, params: { step: :finish_packaging, format: :json }

      expect(response).to have_http_status(:not_found)
    end

    it 'responds with 404 (NOT FOUND) if invalid project token was specified' do
      cookies.encrypted[:project_id] = '123'

      patch :update, params: { step: :finish_packaging, format: :json }

      expect(response).to have_http_status(:not_found)
    end
  end
end
