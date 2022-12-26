# frozen_string_literal: true

ActiveAdmin.register Feedback do
  actions :index, :show, :destroy

  permit_params :name, :email, :subject, :message

  filter :name
  filter :email
  filter :subject
  filter :message
end
