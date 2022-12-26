# frozen_string_literal: true

class Spot < ApplicationRecord
  include AASM
  include SpotExpireMethods
  include Wisper::Publisher

  has_one :design, dependent: :destroy
  has_one :unread_design, -> { where(unread: true) }, class_name: 'Design'

  belongs_to :designer
  belongs_to :project, counter_cache: true

  has_one :client, through: :project

  validates :designer, :project, presence: true

  delegate :uploaded_file, to: :design, allow_nil: true
  delegate :reservation_expire_days, to: :project, allow_nil: true

  delegate :brand_identity?,
           :contest?,
           :one_to_one?,
           to: :project, allow_nil: true, prefix: true

  scope :without_design,          -> { includes(:design).where(designs: { id: nil }) }
  scope :not_eliminated,          -> { where.not(state: STATE_ELIMINATED) }
  scope :finalist_states,         -> { where(state: FINALIST_STATES) }
  scope :visible,                 -> { where(state: VISIBLE_STATES) }
  scope :can_be_deleted_by_admin, -> { where(state: CAN_BE_DELETED_BY_ADMIN_STATES) }

  scope :of_contest_project, -> { joins(:project).where(projects: { project_type: Project.project_types[:contest] }) }
  scope :of_one_to_one_project, -> { joins(:project).where(projects: { project_type: Project.project_types[:one_to_one] }) }

  scope :active, lambda {
    joins(:project)
      .where(spots: { state: [:in_queue, :reserved, :design_uploaded] }, projects: { state: :design_stage })
      .or(joins(:project).where(spots: { state: [:finalist, :stationery, :stationery_uploaded] }, projects: { state: :finalist_stage }))
      .or(joins(:project).where(spots: { state: :winner }, projects: { state: [:files_approval, :review_files] }))
  }

  aasm column: :state do
    state :available, initial: true
    state :in_queue
    state :reserved
    state :design_uploaded
    state :stationery
    state :stationery_uploaded
    state :finalist
    state :winner

    state :expired
    state :eliminated
    state :deleted_by_admin

    event :queue do
      transitions from: :available, to: :in_queue
    end

    event :reserve do
      before do
        broadcast(:spot_reserved, self) if in_queue?
      end

      after { update!(reserved_state_started_at: Time.zone.now) }
      transitions from: [:available, :in_queue], to: :reserved
    end

    event :upload_design do
      transitions from: :reserved, to: :finalist, unless: :project_contest?
      transitions from: :reserved, to: :design_uploaded, if: :project_contest?
    end

    event :expire do
      transitions from: :reserved, to: :expired
    end

    event :eliminate, after: :publish_design_eliminated do
      transitions to: :eliminated
    end

    event :mark_as_deleted_by_admin, after: :publish_design_eliminated_by_admin do
      # Can be in state DELETED_BY_ADMIN in two cases:
      #   1) when admin deletes design by himself
      #
      #   2) when user's portfolio has been approved and he participated in
      #      the projects, but uploaded designs of bad quality and admin
      #      disapproved his portfolio (brand identity or packaging) =>
      #      designer can't participate in projects that belongs to the
      #      disapproved type and existing spots must disappear from platform

      pre_finalist_states = [:in_queue, :reserved, :design_uploaded]
      finalist_states = [:stationery, :stationery_uploaded, :finalist]

      transitions from: pre_finalist_states + finalist_states, to: :deleted_by_admin
    end

    event :block do
      transitions to: :eliminated
    end

    event :mark_as_finalist do
      transitions from: :design_uploaded, to: :finalist, unless: :project_brand_identity?
      transitions from: :design_uploaded, to: :stationery, if: :project_brand_identity?
    end

    event :upload_stationery do
      transitions from: :stationery, to: :stationery_uploaded
    end

    event :approve_stationery do
      transitions from: :stationery_uploaded, to: :finalist
    end

    event :mark_as_winner do
      transitions from: :finalist, to: :winner
    end
  end

  def can_be_eliminated?
    CAN_BE_ELIMINATED_STATES.include?(state)
  end

  private

  def publish_design_eliminated
    broadcast(:design_eliminated, design)
  end

  def publish_design_eliminated_by_admin
    broadcast(:design_eliminated_by_admin, design)
  end

  VISIBLE_STATES = [
    STATE_RESERVED,
    STATE_DESIGN_UPLOADED,
    STATE_STATIONERY,
    STATE_STATIONERY_UPLOADED,
    STATE_FINALIST,
    STATE_WINNER
  ].map(&:to_s)

  FINALIST_STATES = [
    STATE_STATIONERY,
    STATE_STATIONERY_UPLOADED,
    STATE_FINALIST
  ].map(&:to_s)

  CAN_BE_ELIMINATED_STATES = [
    STATE_DESIGN_UPLOADED,
    STATE_STATIONERY_UPLOADED,
    STATE_FINALIST
  ].map(&:to_s)

  CAN_BE_DELETED_BY_ADMIN_STATES = [
    STATE_IN_QUEUE,
    STATE_RESERVED,
    STATE_DESIGN_UPLOADED,
    STATE_STATIONERY,
    STATE_STATIONERY_UPLOADED,
    STATE_FINALIST
  ].map(&:to_s)

  CAN_HAVE_DESIGN_STATES = [
    STATE_DESIGN_UPLOADED,
    STATE_STATIONERY,
    STATE_STATIONERY_UPLOADED,
    STATE_FINALIST,
    STATE_WINNER,
    STATE_ELIMINATED
  ].map(&:to_s)
end
