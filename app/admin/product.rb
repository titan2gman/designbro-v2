# frozen_string_literal: true

ActiveAdmin.register Product do
  menu parent: 'Products'

  config.filters = false

  includes :product_category

  permit_params :name, :short_name, :key, :price, :description, :product_category_id,
                :brand_name_hint, :brand_additional_text_hint, :brand_background_story_hint,
                :product_text_label, :product_text_hint,
                :what_is_it_for_label, :what_is_it_for_hint,
                :product_size_label, :product_size_hint,
                :tip_and_tricks_url,
                :contest_design_stage_expire_days, :one_to_one_design_stage_expire_days,
                :contest_finalist_stage_expire_days, :one_to_one_finalist_stage_expire_days,
                :files_stage_expire_days,
                :review_files_stage_expire_days,
                :reservation_expire_days,
                :active,
                additional_design_prices_attributes: [:id, :quantity, :amount],
                additional_screen_prices_attributes: [:id, :quantity, :amount]

  actions :index, :new, :show, :edit, :update

  index do
    column :name
    column :key
    column :price
    column :description
    column :product_category
    column :brand_name_hint
    column :brand_additional_text_hint
    column :brand_background_story_hint
    column :product_text_label
    column :product_text_hint
    column :product_size_label
    column :product_size_hint
    column :what_is_it_for_label
    column :what_is_it_for_hint
    column :tip_and_tricks_url
    column :created_at
    column :updated_at
    column :contest_design_stage_expire_days
    column :one_to_one_design_stage_expire_days
    column :contest_finalist_stage_expire_days
    column :one_to_one_finalist_stage_expire_days
    column :files_stage_expire_days
    column :review_files_stage_expire_days
    column :reservation_expire_days
    column :active
    actions
  end

  show do |product|
    attributes_table do
      row :product_category
      row :name
      row :short_name
      row :key
      row :price
      row :description
      row :brand_name_hint
      row :brand_additional_text_hint
      row :brand_background_story_hint
      row :product_text_label
      row :product_text_hint
      row :product_size_label
      row :product_size_hint
      row :what_is_it_for_label
      row :what_is_it_for_hint
      row :tip_and_tricks_url
      row :contest_design_stage_expire_days
      row :one_to_one_design_stage_expire_days
      row :contest_finalist_stage_expire_days
      row :one_to_one_finalist_stage_expire_days
      row :files_stage_expire_days
      row :review_files_stage_expire_days
      row :reservation_expire_days
      row :created_at
      row :updated_at
      row :active
    end

    panel 'Additional design prices' do
      table_for product.additional_design_prices do
        column :quantity
        column :amount
      end
    end

    panel 'Additional screen prices' do
      table_for product.additional_screen_prices do
        column :quantity
        column :amount
      end
    end
  end

  form do |_f|
    semantic_errors

    inputs do
      input :product_category
      input :name, as: :string
      input :short_name, as: :string
      input :key, as: :string
      input :description, as: :text
      input :price, as: :number
      input :brand_name_hint, as: :string
      input :brand_additional_text_hint, as: :string
      input :brand_background_story_hint, as: :string
      input :product_text_label, as: :string
      input :product_text_hint, as: :string
      input :product_size_label, as: :string
      input :product_size_hint, as: :string
      input :what_is_it_for_label, as: :string
      input :what_is_it_for_hint, as: :string
      input :tip_and_tricks_url, as: :string
      input :contest_design_stage_expire_days, as: :number
      input :one_to_one_design_stage_expire_days, as: :number
      input :contest_finalist_stage_expire_days, as: :number
      input :one_to_one_finalist_stage_expire_days, as: :number
      input :files_stage_expire_days, as: :number
      input :review_files_stage_expire_days, as: :number
      input :reservation_expire_days, as: :number
      input :active, as: :boolean
    end

    panel 'Additional design prices' do
      has_many :additional_design_prices, allow_destroy: false, new_record: false do |f|
        f.input :quantity, input_html: { disabled: true }
        f.input :amount, as: :number, input_html: { min: 0 }
      end
    end

    panel 'Additional screen prices' do
      has_many :additional_screen_prices, allow_destroy: false, new_record: false do |f|
        f.input :quantity, input_html: { disabled: true }
        f.input :amount, as: :number, input_html: { min: 0 }
      end
    end

    actions
  end
end
