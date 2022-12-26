# frozen_string_literal: true

ActiveAdmin.register Payout do
  permit_params :payout_state
  actions :index, :show, :edit, :update

  index do
    column :id
    column :designer
    column :first_name
    column :last_name
    column :amount do |payout|
      "$#{payout.amount / 100}"
    end
    column :payout_method
    column :paypal_email
    column :iban
    column :swift
    column :country
    column :state
    column :city
    column :address1
    column :address2
    column :phone
    column :payout_state do |payout|
      I18n.t("active_admin.payout.payout_state.#{payout.payout_state}")
    end
    column :payout_id

    actions
  end

  show do |_payout|
    attributes_table do
      row :id
      row :designer
      row :first_name
      row :last_name
      row :amount do |payout|
        "$#{payout.amount / 100}"
      end
      row :payout_method
      row :paypal_email
      row :iban
      row :swift
      row :country
      row :state
      row :city
      row :address1
      row :address2
      row :phone
      row :payout_state do |payout|
        I18n.t("active_admin.payout.payout_state.#{payout.payout_state}")
      end
      row :payout_id
    end
  end

  form do |_|
    semantic_errors

    inputs do
      input :payout_state, as: :select, collection: Payout.aasm.states.map { |payout| [I18n.t("active_admin.payout.payout_state.#{payout.name}"), payout.name] }
    end

    actions
  end

  filter :amount
  filter :designer
  filter :first_name
  filter :last_name
  filter :country
  filter :city
  filter :state
  filter :payout_method
end
