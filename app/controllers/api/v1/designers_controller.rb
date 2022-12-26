# frozen_string_literal: true

module Api
  module V1
    class DesignersController < Api::V1::ApplicationController
      before_action :authenticate_designer!

      def update
        @form = DesignerForm.new(designer_params)
        @form.save

        respond_with @form.designer
      end

      def experience
        @form = DesignerExperienceForm.new(experience_params)
        @form.save

        respond_with @form.designer, include: 'portfolio_works'
      end

      def portfolio_settings
        @form = DesignerPortfolioSettingsForm.new(portfolio_settings_params)
        @form.save

        respond_with @form.designer
      end

      private

      def designer_params
        params.require(:designer).permit(
          :email,
          :display_name,
          :first_name,
          :last_name,
          :gender,
          :date_of_birth,
          :date_of_birth_day,
          :date_of_birth_month,
          :date_of_birth_year,
          :experience_english,
          :address1,
          :address2,
          :country_code,
          :state_name,
          :phone,
          :city,
          :zip,
          :online_portfolio,
          experiences: [:id, :product_category_id, :experience]
        ).to_h.merge(id: designer.id)
      end

      def experience_params
        params.require(:designer).permit(
          experiences: [:id, :product_category_id, :experience],
          portfolio_works: [:id, :uploaded_file_id, :product_category_id, :description, :new]
        ).to_h.merge(id: designer.id)
      end

      def portfolio_settings_params
        params.require(:designer).permit(
          :description,
          :one_to_one_available,
          :avatar_id,
          :uploaded_hero_image_id,
          languages: []
        ).to_h.merge(id: designer.id)
      end
    end
  end
end
