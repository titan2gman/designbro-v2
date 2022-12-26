# frozen_string_literal: true

class ClientSerializer < ActiveModel::Serializer
  attributes :first_name,
             :last_name,
             :notify_news,
             :notify_projects_updates,
             :notify_messages_received,
             :inform_on_email,
             :user_type,
             :user_id,
             :email,
             :created_at,
             :user_hash,
             :preferred_payment_method,
             :god,
             :credit_card_number,
             :credit_card_provider,
             # delegated from company
             :company_name,
             :country_code,
             :address1,
             :address2,
             :city,
             :state_name,
             :zip,
             :phone,
             :vat,

             :projects_count

  def user_type
    'client'
  end

  def user_hash
    return if !Rails.env.production? && !Rails.env.staging?

    OpenSSL::HMAC.hexdigest(
      'sha256',
      ENV.fetch('INTERCOM_IDENTITY_VERIFICATION_SECRET'),
      object.user_id.to_s
    )
  end

  def projects_count
    object.company.projects.count
  end
end
