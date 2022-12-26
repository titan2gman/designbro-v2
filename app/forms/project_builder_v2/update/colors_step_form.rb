# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class ColorsStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :new_colors, Array
      attribute :colors_comment, String

      private

      def persist!
        update_project
        update_step
      end

      def update_project
        project.update(
          new_colors: new_colors,
          colors_comment: colors_comment
        )
      end
    end
  end
end
