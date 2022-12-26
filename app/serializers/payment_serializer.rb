# frozen_string_literal: true

class PaymentSerializer < ActiveModel::Serializer
  attributes :project_name, :created_at, :payment_id, :project_id

  def project_name
    object.project.name
  end

  def project_id
    object.project.id
  end
end
