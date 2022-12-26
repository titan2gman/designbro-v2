# frozen_string_literal: true

ActiveAdmin.register AbandonedCartReminder do
  menu parent: 'Static'

  config.filters = false
  config.sort_order = 'step_asc'

  permit_params :minutes_to_reminder

  actions :index, :show, :edit, :update

  index do
    column :name
    column :step
    column :minutes_to_reminder
    actions
  end

  show do
    attributes_table do
      row :name
      row :step
      row :minutes_to_reminder
      row :created_at
      row :updated_at
    end
  end

  form do |_f|
    semantic_errors

    inputs do
      input :minutes_to_reminder
    end

    actions
  end
end
