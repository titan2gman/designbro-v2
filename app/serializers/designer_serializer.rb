# frozen_string_literal: true

class DesignerSerializer < ActiveModel::Serializer
  attributes :display_name,
             :country_code,
             :first_name,
             :last_name,
             :gender,
             :date_of_birth,
             :experience_english,
             :portfolio_uploaded,
             :state_name,
             :address1,
             :address2,
             :state,
             :email,
             :phone,
             :city,
             :zip,
             :available_for_payout,
             :all_time_earned,
             :notify_messages_received,
             :notify_projects_updates,
             :notify_news,
             :inform_on_email,
             :user_type,
             :user_id,
             :created_at,
             :user_hash,
             :experiences,
             :max_active_spots_count,
             :active_spots_count,
             :description,
             :languages,
             :one_to_one_available,
             :avatar_url,
             :avatar_uploaded_file_id,
             :uploaded_hero_image_url,
             :uploaded_hero_image_uploaded_file_id

  has_many :portfolio_works
  has_many :designer_experiences

  # has_one :avatar
  # has_one :uploaded_hero_image

  def state
    object.user.state
  end

  def date_of_birth
    object.date_of_birth&.strftime('%m-%d-%Y')
  end

  def email
    object.user.email
  end

  def all_time_earned
    object.all_time_earned / 100
  end

  def available_for_payout
    object.available_for_payout / 100
  end

  def user_type
    'designer'
  end

  def experiences
    object.designer_experiences
  end

  def user_hash
    return if !Rails.env.production? && !Rails.env.staging?

    OpenSSL::HMAC.hexdigest(
      'sha256',
      ENV.fetch('INTERCOM_IDENTITY_VERIFICATION_SECRET'),
      object.user_id.to_s
    )
  end

  def avatar_url
    object.avatar&.file&.url
  end

  def avatar_uploaded_file_id
    object.avatar&.id
  end

  def uploaded_hero_image_url
    object.uploaded_hero_image&.file&.url
  end

  def uploaded_hero_image_uploaded_file_id
    object.uploaded_hero_image&.id
  end
end
