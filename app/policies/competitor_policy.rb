class CompetitorPolicy < ApplicationPolicy
  def create?
    brand_has_no_clients? || brand_belongs_to_client?
  end

  private

  def brand_has_no_clients?
    record.brand.clients.empty?
  end

  def brand_belongs_to_client?
    record.brand.clients.include?(client)
  end
end
