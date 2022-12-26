# frozen_string_literal: true

class Designer < ApplicationRecord
  include AASM

  include Discard::Model
  default_scope -> { kept }

  belongs_to :user, dependent: :destroy
  has_many :portfolio_works, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :winner_spots, -> { where(state: :winner) }, class_name: 'Spot'
  has_many :designs, through: :spots, dependent: :destroy
  has_many :projects, -> { distinct }, through: :spots
  has_many :payouts
  has_many :earnings
  has_many :reviews
  has_many :direct_conversation_messages, through: :designs
  has_many :reviews, through: :designs
  has_many :designer_experiences, dependent: :destroy
  has_many :approved_designer_experiences, -> { approved }, class_name: 'DesignerExperience'

  has_many :designer_client_blocks
  has_many :clients_that_blocked, through: :designer_client_blocks, source: :client

  has_many :designer_ndas, dependent: :destroy
  has_many :accepted_ndas, through: :designer_ndas, source: :nda

  has_one :avatar, as: :entity, class_name: 'UploadedFile::Avatar', dependent: :destroy
  has_one :uploaded_hero_image, as: :entity, class_name: 'UploadedFile::HeroImage', dependent: :destroy

  belongs_to :hero_image, class_name: 'FeaturedImage', optional: true

  scope :visible, -> { where(visible: true) }

  validates :user, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :country_code, presence: true
  # TODO: remove legacy field
  # validates :age, presence: true
  # validates :date_of_birth, presence: true
  validates :gender, presence: true
  validates :experience_english, presence: true
  validates :display_name, presence: true, uniqueness: true

  validate :allowed_display_name

  delegate :email, :last_seen_at, :notify_news, :notify_projects_updates, :state,
           :notify_messages_received, :inform_on_email, to: :user, allow_nil: true

  enum gender: { female: 1, male: 0, unknown: -1 }

  enum experience_english: {
    not_good_english: 0,
    acceptable_english: 1,
    good_english: 2,
    native_english: 3
  }

  accepts_nested_attributes_for :designer_experiences
  accepts_nested_attributes_for :portfolio_works
  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for :uploaded_hero_image

  after_discard do
    user.update(notify_news: false, notify_projects_updates: false, notify_messages_received: false)
  end

  def approved_product_category_ids
    designer_experiences.where(state: :approved).pluck(:product_category_id)
  end

  def all_time_earned
    earnings.sum(:amount)
  end

  def available_for_payout
    earnings.earned.sum(:amount)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def active_projects
    projects.merge(Spot.visible)
  end

  def stats
    DesignerStats.new(self)
  end

  def allowed_display_name
    errors.add(:display_name, '"." and "@" are not allowed') if /[.@]/.match?(display_name) && !/[.@]/.match?(display_name_was)
  end

  def count_of_approved_states
    designer_experiences.where(state: 'approved').count
  end

  def count_of_disapproved_states
    designer_experiences.where(state: 'disapproved').count
  end

  def active_spots_count
    spots.active.count
  end
end
