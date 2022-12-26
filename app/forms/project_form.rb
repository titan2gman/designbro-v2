# frozen_string_literal: true

class ProjectForm < BaseForm
  include Wisper::Publisher

  presents :project

  private

  def persist!
    return unless project.review_files?

    project.approve_files!
    EarningCreator::PayWinner.call(project)
    broadcast(:approve_files, project)
  end
end
