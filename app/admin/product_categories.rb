# frozen_string_literal: true

ActiveAdmin.register ProductCategory do
  menu parent: 'Products'

  config.filters = false

  permit_params :name

  actions :index, :new, :show, :edit, :update

  index do
    column :name
    column :created_at
    column :updated_at
    actions
  end

  show do |product_category|
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end

    panel 'Products' do
      table_for product_category.products do
        column :name
        column :key
        column :price
        column :description
      end
    end
  end

  form do |_f|
    semantic_errors

    inputs do
      input :name, as: :string
    end

    actions
  end
end
