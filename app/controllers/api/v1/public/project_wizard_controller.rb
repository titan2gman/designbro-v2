# frozen_string_literal: true

module Api
  module V1
    module Public
      class ProjectWizardController < Api::V1::ApplicationController
        load_and_authorize_resource class: Project, only: [:show]

        before_action :initialize_create_form, only: [:create]

        before_action :initialize_step, only: [:update]
        before_action :initialize_update_form, only: [:update]

        serialization_scope :view_context

        def show
          respond_with @project_wizard, serializer: ProjectFormSerializer, include: '**'
        end

        def create
          @form.save

          respond_with @form.project, serializer: ProjectFormSerializer, include: '**'
        end

        def update
          success = @form.save

          return head :ok if success && !params[:upgrade_project_state]

          set_project_id_cookie(@form.project.current_step ? @form.project.id : nil)

          respond_with @form.project, serializer: ProjectFormSerializer, include: '**'
        end

        private

        def initialize_step
          @step = ProjectBuilderStep.find(params[:step_id])
        end

        def initialize_update_form
          @form = "NewProject::#{@step.form_name}".constantize.new(project_params)
        end

        def initialize_create_form
          @form = params[:project][:project_type] == 'one_to_one' ? NewProject::CreateOneToOneForm.new(create_params) : NewProject::CreateContestForm.new(create_params)
          @form.subscribe(ProjectListener.new)
        end

        def project_params
          params.require(:project).permit!.to_h.merge(
            id: params[:id],
            client: client,
            step: @step,
            upgrade_project_state: params[:upgrade_project_state]
          )
        end

        def create_params
          params.require(:project).permit(
            :product_id,
            :brand_id,
            :brand_name,
            :project_type,
            :designer_id,
            :payment_type,
            :payment_method_id,
            :payment_intent_id,
            :paypal_payment_id,
            :discount_code
          ).merge(
            client: client,
            referrer: cookies[:designbro_referrer]
          )
        end

        def set_project_id_cookie(project_id)
          cookies.permanent.encrypted[:project_id] = project_id
        end
      end
    end
  end
end
