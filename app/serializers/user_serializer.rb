# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :notify_news, :notify_projects_updates, :notify_messages_received,
             :inform_on_email
end
