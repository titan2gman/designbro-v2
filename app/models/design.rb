# frozen_string_literal: true

class Design < ApplicationRecord
  include Wisper::Publisher

  has_paper_trail on: [:update]

  belongs_to :spot

  has_one :project,  through: :spot
  has_one :designer, through: :spot

  has_one :product, through: :project

  has_many :direct_conversation_messages, dependent: :destroy
  has_many :reviews, dependent: :destroy

  belongs_to :uploaded_file, class_name: 'UploadedFile::DesignFile', validate: true, dependent: :destroy

  delegate :project_type,
           :product_key,
           to: :project, allow_nil: true

  enum eliminate_reason: {
    not_in_line: 0,
    not_communicate: 1,
    not_understand: 2,
    looking_for_something_else: 3,
    other: 4
  }

  # SCOPES:

  scope :not_eliminated, -> { joins(:spot).merge(Spot.not_eliminated) }
  scope :finalist,       -> { joins(:spot).merge(Spot.finalist_states) }
  scope :visible,        -> { joins(:spot).merge(Spot.visible) }

  scope :by_spot_state, lambda { |spot_state|
    joins(:spot).where(spots: { state: spot_state })
  }

  scope :by_client, lambda { |client_id|
    joins(project: { brand_dna: { brand: { company: :clients } } }).where('clients.id = ?', client_id)
  }

  scope :by_blocked_flag, lambda { |blocked|
    if blocked == 'blocked'
      DesignsQuery::Blocked.call
    else
      DesignsQuery::NonBlocked.call
    end
  }

  validates :uploaded_file, presence: true

  validates :name, presence: true, length: { maximum: 30 }

  validates :rating, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5,
    only_integer: true,
    allow_nil: true
  }

  validate :spot_state, on: :create

  # remove it after refactoring DesignSerializer
  delegate :winner?,   to: :spot
  delegate :finalist?, to: :spot

  delegate :eliminate!,        to: :spot
  delegate :mark_as_winner!,   to: :spot
  delegate :mark_as_finalist!, to: :spot

  delegate :approve_stationery!, to: :spot

  delegate :can_be_eliminated?, to: :spot

  delegate :state, to: :spot

  def self.ransackable_scopes(*args)
    super(*args) + ['by_spot_state', 'by_blocked_flag', 'by_client']
  end

  def design_versions
    [*versions.map(&:reify), self]
      .uniq(&:uploaded_file_id)
  end

  def restore(uploaded_file_id)
    version = versions.where_object(uploaded_file_id: uploaded_file_id.to_i).first

    return if version.blank?

    design = version.reify

    if version_exists?
      PaperTrail.request(enabled: false) do
        design.save
      end
    else
      design.save
    end

    design
  end

  def version_exists?
    versions.where_object(uploaded_file_id: uploaded_file_id).any?
  end

  private

  def spot_state
    errors.add(:spot, :invalid) unless spot&.reserved?
  end
end
