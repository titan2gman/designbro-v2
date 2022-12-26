class Client::ProjectPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    project_has_no_clients? || project_belongs_to_client?
  end

  def update?
    project_has_no_clients? || project_belongs_to_client?
  end

  private

  def project_has_no_clients?
    record.clients.empty?
  end

  def project_belongs_to_client?
    record.clients.include?(client)
  end
end
