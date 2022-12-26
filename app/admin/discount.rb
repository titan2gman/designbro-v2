# frozen_string_literal: true

ActiveAdmin.register Discount do
  permit_params :code,
                :discount_type,
                :value,
                :begin_date,
                :end_date,
                :max_num

  form do |_f|
    semantic_errors

    inputs do
      if object.new_record?
        input :code, input_html: { value: object.code || DiscountCodeGenerator.new.call }
        input :discount_type, as: :select, collection: enum_to_input_collection(Discount.discount_types)
        input :value
      else
        input :code, input_html: { disabled: true }
        input :discount_type, input_html: { disabled: true }
        input :value, input_html: { disabled: true }
      end
      input :begin_date, as: :datepicker
      input :end_date, as: :datepicker
      input :max_num, label: I18n.t('active_admin.discount.max_num')
    end

    actions
  end

  index do
    selectable_column
    id_column
    column :code
    column :discount_type
    column :value
    column :begin_date
    column :end_date
    column I18n.t('active_admin.discount.used_num'), &:used_num
    column I18n.t('active_admin.discount.max_num'), &:max_num
    actions
  end

  show do
    attributes_table do
      row :id
      row :code
      row :discount_type
      row :value
      row :begin_date
      row :end_date
      row I18n.t('active_admin.discount.used_num'), &:used_num
      row I18n.t('active_admin.discount.max_num'), &:max_num
    end
  end

  filter :code

  filter :discount_type, as: :select, collection: lambda {
    enum_to_filter_collection(Discount.discount_types)
  }

  filter :value
  filter :begin_date
  filter :end_date
  filter :used_num, label: I18n.t('active_admin.discount.used_num')
  filter :max_num, label: I18n.t('active_admin.discount.max_num')
  filter :state_in, label: 'State', as: :select, collection: ['future', 'active', 'finished']
end
