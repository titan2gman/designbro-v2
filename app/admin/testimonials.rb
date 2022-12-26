# frozen_string_literal: true

ActiveAdmin.register Testimonial do
  permit_params :header,
                :body,
                :rating,
                :credential,
                :company

  index do
    selectable_column

    column :id
    column :header
    column :body
    column :rating
    column :credential
    column :company
    actions
  end

  show do
    attributes_table do
      row :id
      row :header
      row :body
      row :rating
      row :credential
      row :company
      row :created_at
      row :updated_at
    end
  end

  form do |_f|
    semantic_errors

    inputs do
      input :header
      input :body
      input :rating
      input :credential
      input :company
    end

    actions
  end
end
