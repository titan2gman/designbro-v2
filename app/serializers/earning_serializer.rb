# frozen_string_literal: true

class EarningSerializer < ActiveModel::Serializer
  attributes :project_name, :created_at, :project_id, :amount

  def project_name
    object.project.name
  end

  def project_id
    object.project.id
  end

  def amount
    object.amount / 100
  end
end
