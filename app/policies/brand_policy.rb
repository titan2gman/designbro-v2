class BrandPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if client
        scope.where(company_id: client.company_id)
      else
        []
      end
    end
  end
end
