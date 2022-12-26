# frozen_string_literal: true

ActiveAdmin.register VatRate do
  menu parent: 'Static'

  permit_params :country_name, :percent
  actions :index, :show, :edit, :update

  form do |_f|
    semantic_errors

    inputs do
      input :country_name
      input :percent
    end

    actions
  end
end
