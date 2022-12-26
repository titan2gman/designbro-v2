# frozen_string_literal: true

module Api
  module V2
    module Client
      class ProjectsController < Api::V2::ApplicationController
        before_action :set_and_authorize_project, only: [:show, :update]
        before_action :set_step, only: [:update]

        def show
          render json: ProjectBlueprint.render(@project, view: :project_builder)
        end

        def create
          authorize [:client, Project]

          @form = ProjectBuilderV2::Create::ContestForm.new(create_params)
          @form.save

          render json: ProjectBlueprint.render(@form.project, view: :project_builder)
        end

        def update
          @form = "ProjectBuilderV2::Update::#{@step.form_name}".constantize.new(update_params)

          success = @form.save

          return head :ok if success && !params[:upgrade_project_state]

          render json: ProjectBlueprint.render(@form.project, view: :project_builder)
        end

        private

        def set_and_authorize_project
          @project = Project.includes(
            additional_documents: :additional_document,
            competitors: :competitor_logo,
            existing_designs: :existing_logo,
            inspirations: :inspiration_image
          ).find(params[:id])
          authorize [:client, @project]
        end

        def set_step
          @step = ProjectBuilderStep.find_by!(path: params[:step], product_id: @project.product_id)
        end

        def create_params
          params.require(:project).permit(
            :product_key
          ).merge(
            client: client,
            referrer: cookies[:designbro_referrer]
          )
        end

        def update_params
          params.require(:project).permit(
            :brand_name,
            :brand_dna_bold_or_refined,
            :brand_dna_detailed_or_clean,
            :brand_dna_handcrafted_or_minimalist,
            :brand_dna_serious_or_playful,
            :brand_dna_stand_out_or_not_from_the_crowd,
            :brand_dna_traditional_or_modern,
            :brand_dna_value_or_premium,
            :brand_dna_youthful_or_mature,
            :brand_dna_masculine_or_premium,
            :brand_dna_low_income_or_high_income,
            :has_existing_design,
            :brand_additional_text,
            :brand_description,
            :colors_comment,
            :ideas_or_special_requirements,
            :nda_type,
            :upgrade_package,
            :max_spots_count,
            :max_screens_count,
            :discount_code,
            :vat,
            :country_code,
            :discount_code,
            :company_name,
            :last_name,
            :first_name,
            brand_dna_target_country_codes: [],
            brand_example_ids: [],
            new_colors: [],
            existing_designs: [:id, :comment, :_destroy],
            inspirations: [:id, :comment, :_destroy],
            competitors: [:id, :rating, :comment, :_destroy],
            additional_documents: [:id, :comment, :_destroy]
          ).merge(
            id: params[:id],
            step: @step,
            upgrade_project_state: params[:upgrade_project_state],
            client: client,
            ip: request.remote_ip
          )
        end
      end
    end
  end
end
