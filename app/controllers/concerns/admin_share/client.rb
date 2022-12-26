# frozen_string_literal: true

module AdminShare
  module Client
    extend ActiveSupport::Concern

    def self.included(base)
      base.send(:show) do
        attributes_table do
          row :id
          row :email
          row :first_name
          row :last_name
          row :company_name
          row :address1
          row :address2
          row :city
          row :country_code
          row :state_name
          row :zip
          row :phone
          row :vat
          row :state
        end
      end

      base.send(:index) do
        selectable_column
        column :id
        column :email
        column :first_name
        column :last_name
        column :country_code
        column :phone
        column :god
        column :opt_out
        column :stripe_customer
        column :preferred_payment_method
        column :created_at
        column :updated_at
        actions
      end

      base.send(:csv) do
        column :id
        column :email
        column :first_name
        column :last_name
        column :country_code
        column :phone
        column :god
        column :opt_out
        column :stripe_customer
        column :preferred_payment_method
        column :created_at
        column :updated_at
      end

      base.send(:permit_params, :zip,
                :vat,
                :city,
                :phone,
                :address1,
                :address2,
                :last_name,
                :first_name,
                :state_name,
                :country_code,
                :company_name,
                :opt_out)
    end
  end
end
