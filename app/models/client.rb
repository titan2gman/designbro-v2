# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :company

  has_many :designer_client_blocks, dependent: :destroy

  has_many :payments, through: :projects
  has_many :spots, through: :projects
  has_many :designs, through: :projects
  has_many :direct_conversation_messages, through: :designs

  delegate :email,
           :state,
           :active?,
           :notify_news,
           :last_seen_at,
           :inform_on_email,
           :notify_projects_updates,
           :notify_messages_received,
           to: :user, allow_nil: true

  delegate :country_code,
           :address1,
           :address2,
           :city,
           :state_name,
           :zip,
           :phone,
           :vat,
           :company_name,
           to: :company, allow_nil: true

  scope :all_except, ->(clients) { where.not(id: clients.ids) }

  scope :did_not_block, ->(designer) { all_except(designer.clients_that_blocked) }

  enum preferred_payment_method: {
    credit_card: 'credit_card',
    paypal: 'paypal',
    bank_transfer: 'bank_transfer'
  }

  def display_name
    "#{first_name} #{last_name}"
  end

  alias name display_name
end
