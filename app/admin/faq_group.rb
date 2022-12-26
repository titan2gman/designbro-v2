# frozen_string_literal: true

ActiveAdmin.register FaqGroup, as: 'FAQ' do
  menu label: 'FAQs'

  permit_params :name, faq_items_attributes: [:id, :name, :answer, :_destroy]

  filter :name
  filter :faq_items

  show do |faq_group|
    panel 'Table of Contents' do
      table_for faq_group.faq_items do
        column 'Question', :name
        column :answer, class: 'pre-wrap'
      end
    end
  end

  form do |form|
    form.inputs :name

    form.inputs do
      form.has_many :faq_items, heading: 'FAQs', allow_destroy: true, new_record: true do |faq_item|
        faq_item.input :name, label: 'Question'
        faq_item.input :answer
      end
    end

    form.actions
  end
end
