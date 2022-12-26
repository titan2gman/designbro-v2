# frozen_string_literal: true

ActiveAdmin.register StartNotificationRequest do
  actions :index, :destroy

  filter :email
  filter :created_at
end
