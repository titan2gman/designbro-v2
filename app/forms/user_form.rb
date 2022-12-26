# frozen_string_literal: true

class UserForm < BaseForm
  presents :user

  attribute :notify_news, Boolean
  attribute :notify_messages_received, Boolean
  attribute :notify_projects_updates, Boolean
  attribute :inform_on_email, String

  attribute :email, String
  attribute :password, String

  attribute :approve, Boolean

  private

  def persist!
    return user.approve! if approve && user.pending?

    if auth_params
      user.update_without_password(email: email) if user.email != email
      user.assign_attributes(auth_params)
    else
      user.assign_attributes(params)
    end
    merge_errors(user) unless user.valid?
    user.save
  end

  def merge_errors(assoc)
    assoc.errors.each { |attribute, error| record.object.errors.add(attribute, error) }
  end

  def params
    @params ||= {
      notify_news: notify_news,
      notify_messages_received: notify_messages_received,
      notify_projects_updates: notify_projects_updates,
      inform_on_email: inform_on_email
    }.compact
  end

  def auth_params
    return unless user.pending? && user.client?

    @auth_params ||= { password: password }
  end
end
