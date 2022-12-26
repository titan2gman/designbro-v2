# frozen_string_literal: true

module BindProjectToClient
  extend ActiveSupport::Concern

  included do
    def bind_project_to_client(project, client)
      return unless client && project

      client.projects << project
    end

    def bind_project_to_company(project, company)
      return unless company && project

      company.brands << project.brand
    end
  end
end
