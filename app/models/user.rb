# frozen_string_literal: true

class User < ActiveRecord::Base
  include AASM

  include Discard::Model

  # Include default devise modules.
  devise :trackable,
         :confirmable,
         :recoverable,
         :registerable,
         :rememberable,
         :database_authenticatable

  include DeviseTokenAuth::Concerns::User

  has_one :client, dependent: :destroy
  has_one :designer, dependent: :destroy

  validates :email, uniqueness: { case_sensitive: false }

  delegate :name,
           :projects,
           :display_name, to: :object, allow_nil: true

  aasm column: :state do
    state :pending, initial: true
    state :active
    state :disabled

    event :approve do
      transitions from: [:pending, :disabled], to: :active
    end

    event :disable do
      transitions from: [:pending, :active], to: :disabled
    end
  end

  def token_validation_response
    ActiveModelSerializers::SerializableResource.new(object).as_json[:data]
  end

  def designer?
    object.is_a? Designer
  end

  def client?
    object.is_a? Client
  end

  alias guest? new_record?

  def object
    designer || client
  end

  def valid_for_authentication?
    super && !discarded?
  end

  private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def after_confirmation
    approve! if client
  end
end
