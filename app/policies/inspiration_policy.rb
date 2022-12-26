class InspirationPolicy < ApplicationPolicy
  def create?
    project_has_no_clients? || project_belongs_to_client?
  end

  private

  def project_has_no_clients?
    record.project.clients.empty?
  end

  def project_belongs_to_client?
    record.project.clients.include?(client)
  end
end
