# frozen_string_literal: true

ActiveAdmin.register PayoutMinAmount do
  menu parent: 'Static'

  config.filters = false

  permit_params :amount

  actions :index, :show, :edit, :update

  index do
    column :amount
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :amount
      row :updated_at
    end
  end

  form do |_f|
    semantic_errors

    inputs do
      input :amount
    end

    actions
  end
end
