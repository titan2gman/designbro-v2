# frozen_string_literal: true

class CompanySerializer < ActiveModel::Serializer
  attributes :id,
             :company_name,
             :address1,
             :address2,
             :city,
             :country_code,
             :state_name,
             :zip,
             :phone,
             :vat
end
