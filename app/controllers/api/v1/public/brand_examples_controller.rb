# frozen_string_literal: true

module Api
  module V1
    module Public
      class BrandExamplesController < Api::V1::ApplicationController
        load_and_authorize_resource class: 'UploadedFile::BrandExample'

        def index
          respond_with @brand_examples
        end
      end
    end
  end
end
