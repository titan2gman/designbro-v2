# frozen_string_literal: true

module Api
  module V1
    module Public
      class TestimonialsController < Api::V1::ApplicationController
        before_action :fetch_testimonial
        authorize_resource

        def show
          respond_with @testimonial
        end

        private

        def fetch_testimonial
          @testimonial = Testimonial.random_record
          raise ActiveRecord::RecordNotFound unless @testimonial
        end
      end
    end
  end
end
