# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  menu parent: 'User'

  permit_params :email, :password, :password_confirmation, :view_only

  index do
    selectable_column
    id_column
    column :email
    column :view_only
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :view_only

  form do |f|
    f.inputs 'Admin Details' do
      f.input :email
      f.input :password
      f.input :view_only
      f.input :password_confirmation
    end
    f.actions
  end
end
