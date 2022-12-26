# frozen_string_literal: true

ActiveAdmin.register AbandonedCartDiscount do
  menu parent: 'Static'

  config.filters = false
  config.sort_order = 'id_asc'

  permit_params :discount_id

  actions :index, :show, :edit, :update

  index do
    column :discount_id
    column 'Discount code' do |abandoned_cart_discount|
      abandoned_cart_discount&.discount&.code || 'Please specify discount'
    end
    column 'Discount type' do |abandoned_cart_discount|
      abandoned_cart_discount&.discount&.discount_type
    end
    column 'Value' do |abandoned_cart_discount|
      abandoned_cart_discount&.discount&.value
    end
    column 'Begin date' do |abandoned_cart_discount|
      abandoned_cart_discount&.discount&.begin_date
    end
    column 'End date' do |abandoned_cart_discount|
      abandoned_cart_discount&.discount&.end_date
    end
    column 'Used times actual' do |abandoned_cart_discount|
      abandoned_cart_discount&.discount&.used_num
    end
    column 'Used times max' do |abandoned_cart_discount|
      abandoned_cart_discount&.discount&.max_num
    end
    actions
  end

  show do
    attributes_table do
      row :discount_id
      row 'Discount code' do |abandoned_cart_discount|
        abandoned_cart_discount&.discount&.code || 'Please specify discount'
      end
      row 'Discount type' do |abandoned_cart_discount|
        abandoned_cart_discount&.discount&.discount_type
      end
      row 'Value' do |abandoned_cart_discount|
        abandoned_cart_discount&.discount&.value
      end
      row 'Begin date' do |abandoned_cart_discount|
        abandoned_cart_discount&.discount&.begin_date
      end
      row 'End date' do |abandoned_cart_discount|
        abandoned_cart_discount&.discount&.end_date
      end
      row 'Used times actual' do |abandoned_cart_discount|
        abandoned_cart_discount&.discount&.used_num
      end
      row 'Used times max' do |abandoned_cart_discount|
        abandoned_cart_discount&.discount&.max_num
      end
      row :created_at
      row :updated_at
    end
  end

  form do |_f|
    semantic_errors

    inputs do
      input :discount_id, as: :select,
                          collection: Discount.all.order(:id).map { |dis| ["#{dis.id}, #{dis.code}, #{dis.discount_type}, #{dis.value}", dis.id] }
    end

    actions
  end
end
