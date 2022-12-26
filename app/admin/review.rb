# frozen_string_literal: true

ActiveAdmin.register Review do
  config.filters = false

  actions :index, :show, :edit, :update

  permit_params :designer_comment_answer, :overall_comment_answer, :visible

  includes :designer, { client: :company },
           project: [:product, { brand_dna: { brand: :active_nda } }]

  index do
    column :id
    column :designer_rating
    column :designer_comment
    column :designer_comment_answer
    column :overall_rating
    column :overall_comment
    column :overall_comment_answer

    column :designer do |review|
      review.designer.name
    end

    column :project do |review|
      review.project.name
    end

    column :client do |review|
      review.client.name
    end

    column :company do |review|
      review.client.company.name
    end

    column :product do |review|
      review.project.product.name
    end

    column :nda do |review|
      !review.project.brand.active_nda.free? if review.project.brand.active_nda
    end

    column :visible
    column :created_at

    actions
  end

  show do
    attributes_table do
      row :id
      row :designer_rating
      row :designer_comment
      row :designer_comment_answer
      row :overall_rating
      row :overall_comment
      row :overall_comment_answer
      row :designer do |review|
        review.designer.name
      end
      row :project do |review|
        review.project.name
      end
      row :client do |review|
        review.client.name
      end
      row :company do |review|
        review.client.company.name
      end
      row :product do |review|
        review.project.product.name
      end
      row :nda do |review|
        !review.project.active_nda.free?
      end
      row :visible
      row :created_at
    end
  end

  csv do
    column :id
    column :designer_rating
    column :designer_comment
    column :designer_comment_answer
    column :overall_rating
    column :overall_comment
    column :overall_comment_answer

    column :designer do |review|
      review.designer.name
    end

    column :project do |review|
      review.project.name
    end

    column :client do |review|
      review.client.name
    end

    column :company do |review|
      review.client.company.name
    end

    column :product do |review|
      review.project.product.name
    end

    column :nda do |review|
      !review.project.brand.active_nda.free? if review.project.brand.active_nda
    end

    column :visible
    column :created_at
  end

  form do |_f|
    semantic_errors

    inputs do
      input :designer_rating, as: :number, input_html: { disabled: true }
      input :designer_comment, as: :string, input_html: { disabled: true }
      input :designer_comment_answer, as: :text
      input :overall_rating, as: :number, input_html: { disabled: true }
      input :overall_comment, as: :string, input_html: { disabled: true }
      input :overall_comment_answer, as: :text

      input :visible, as: :boolean
    end

    actions
  end
end
