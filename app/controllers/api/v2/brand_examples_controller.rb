# frozen_string_literal: true

module Api
  module V2
    class BrandExamplesController < Api::V2::ApplicationController
      def index
        @brand_examples = policy_scope(UploadedFile::NewBrandExample).order('random()')

        render json: BrandExampleBlueprint.render(@brand_examples)
      end
    end
  end
end
