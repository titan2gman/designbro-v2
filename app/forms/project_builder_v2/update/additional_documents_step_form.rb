# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class AdditionalDocumentsStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :additional_documents, Array

      private

      def persist!
        update_project!
        update_step
      end

      def update_project!
        project.update(
          additional_documents_attributes: additional_documents
        )
      end
    end
  end
end
