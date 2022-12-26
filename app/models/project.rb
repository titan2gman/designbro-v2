# frozen_string_literal: true

class Project < ApplicationRecord
  include AASM
  include Wisper::Publisher
  include ProjectMoneyMethods
  include ProjectExpireMethods

  include Discard::Model
  default_scope -> { kept }

  MIN_SPOTS_COUNT = 3
  MANUAL_MIN_SPOTS_COUNT = 1
  MAX_SPOTS_COUNT = 10

  MIN_SCREENS_COUNT = 1
  MAX_SCREENS_COUNT = 10

  MIN_COUNT_OF_FINALISTS = 1
  MAX_COUNT_OF_FINALISTS = 3
  MAX_SPOTS_COUNT_RESERVED_BY_DESIGNER = 2

  attr_reader :credit_card

  belongs_to :brand_dna, optional: true

  belongs_to :product
  belongs_to :current_step, class_name: 'ProjectBuilderStep', optional: true

  belongs_to :creator, class_name: 'Client', optional: true

  delegate :bold_or_refined,
           :outmoded_actual,
           :value_or_premium,
           :detailed_or_clean,
           :serious_or_playful,
           :youthful_or_mature,
           :masculine_or_premium,
           :traditional_or_modern,
           :low_income_or_high_income,
           :handcrafted_or_minimalist,
           :stand_out_or_not_from_the_crowd,
           :target_country_codes,
           to: :brand_dna, allow_nil: true, prefix: true

  delegate :name,
           :slogan,
           :additional_text,
           :description,
           :background_story,
           :where_it_is_used,
           :what_is_special,
           to: :brand, allow_nil: true, prefix: true

  delegate :company_name,
           :country_code,
           :vat,
           to: :company, allow_nil: true, prefix: true

  delegate :brand_id, to: :brand_dna, allow_nil: true

  delegate :company_id, to: :brand, allow_nil: true

  delegate :contest_design_stage_expire_days,
           :one_to_one_design_stage_expire_days,
           :contest_finalist_stage_expire_days,
           :one_to_one_finalist_stage_expire_days,
           :files_stage_expire_days,
           :review_files_stage_expire_days,
           :reservation_expire_days,
           :reservation_expire_days,
           :product_category_id,
           to: :product, allow_nil: true

  delegate :path, :component_name,
           to: :current_step, allow_nil: true, prefix: true

  delegate :key, :name, to: :product, allow_nil: true, prefix: true
  delegate :code, to: :discount, allow_nil: true, prefix: true

  delegate :paid?,
           :not_free?,
           to: :active_nda, allow_nil: true, prefix: true

  has_one :brand, through: :brand_dna
  has_one :company, through: :brand

  belongs_to :discount, optional: true
  counter_culture :discount, column_name: :used_num

  belongs_to :packaging_measurements, polymorphic: true, optional: true, dependent: :destroy

  has_many :clients, through: :brand_dna
  has_many :ndas, through: :brand_dna
  has_one :active_nda, class_name: 'Nda', through: :brand_dna

  has_many :payments

  has_many :spots, dependent: :destroy
  has_many :eliminated_spots, -> { where(state: [:eliminated]) }, class_name: 'Spot'
  has_many :expired_spots, -> { where(state: :expired) }, class_name: 'Spot'
  has_many :active_spots, -> { where(state: [:design_uploaded, :finalist, :stationery, :stationery_uploaded, :winner]) }, class_name: 'Spot'
  has_many :busy_spots, -> { where(state: [:design_uploaded, :finalist, :stationery, :stationery_uploaded, :winner, :reserved]) }, class_name: 'Spot'
  has_many :spots_with_uploaded_design, -> { where(state: [:design_uploaded, :finalist, :stationery, :stationery_uploaded, :winner, :eliminated]) }, class_name: 'Spot'

  has_many :designers, -> { distinct }, through: :spots
  has_many :transactions

  has_many :competitors, through: :brand_dna

  has_many :inspirations
  has_many :existing_designs
  has_many :colors, class_name: 'ProjectColor', dependent: :destroy
  has_many :additional_documents, class_name: 'ProjectAdditionalDocument', dependent: :destroy
  has_many :stock_images, class_name: 'ProjectStockImage', dependent: :destroy

  has_many :designs, through: :spots
  has_many :unread_designs, through: :spots

  has_many :brand_examples, class_name: 'ProjectBrandExample', dependent: :destroy, autosave: true

  has_many :bad_brand_examples, -> { bad }, class_name: 'ProjectBrandExample'
  has_many :good_brand_examples, -> { good }, class_name: 'ProjectBrandExample'
  has_many :skip_brand_examples, -> { skip }, class_name: 'ProjectBrandExample'

  has_many :new_brand_examples, class_name: 'BrandExample', dependent: :destroy

  has_one :featured_image, dependent: :destroy

  has_many :project_source_files, dependent: :destroy

  has_many :reserved_spots, -> { reserved }, class_name: 'Spot'

  monetize :discount_amount_cents
  monetize :designer_discount_amount_cents

  validates :max_spots_count, presence: true
  validates :max_screens_count, presence: true
  validates :max_spots_count, numericality: {
    less_than_or_equal_to: MAX_SPOTS_COUNT
  }

  enum design_type: { everything: 0, update_only: 1 }
  enum stock_images_exist: { free_only: 0, free_and_paid: 1, no: 2, yes: 3 }

  enum project_type: { contest: 'contest', one_to_one: 'one_to_one' }

  # for admin panel
  accepts_nested_attributes_for :brand
  accepts_nested_attributes_for :brand_dna
  accepts_nested_attributes_for :additional_documents, allow_destroy: true
  accepts_nested_attributes_for :stock_images, allow_destroy: true
  accepts_nested_attributes_for :spots, allow_destroy: true
  accepts_nested_attributes_for :inspirations, allow_destroy: true
  accepts_nested_attributes_for :existing_designs, allow_destroy: true

  # delegate :price, to: :nda, prefix: true, allow_nil: true
  delegate :packaging_type, to: :packaging_measurements, allow_nil: true

  scope :logo_or_brand_identity, lambda {
    merge(Project.logo).or(Project.brand_identity)
  }

  scope :client_projects, -> { where.not(state: :error) }
  scope :discover,        -> { where(state: DISCOVER_STATES) }
  scope :before_payment,  -> { where(state: BEFORE_PAYMENT_STATES) }
  scope :unfinished,      -> { where(state: UNFINISHED_STATES) }

  scope :completed, -> { where(state: Project::DESIGNER_COMPLETED_STATES) }
  scope :in_progress, -> { where(state: Project::DESIGNER_IN_PROGRESS_STATES) }

  scope :with_reserved_spots, lambda {
    where(state: AVAILABLE_RESERVE_STATES)
      .left_joins(:reserved_spots)
      .group('projects.id')
  }

  scope :spots_free, lambda {
    left_joins(:busy_spots).group('projects.id')
                           .having('count(spots.id) < projects.max_spots_count')
  }

  scope :spots_taken, lambda {
    left_joins(:busy_spots).group('projects.id')
                           .having('count(spots.id) = projects.max_spots_count')
  }

  scope :discoverable_by, lambda { |designer|
    left_joins(:product, clients: :designer_client_blocks)
      .where(products: { product_category_id: designer.approved_product_category_ids })
      .where("designer_client_blocks.designer_id != #{designer.id} OR designer_client_blocks.designer_id IS NULL")
  }

  scope :visible_for, lambda { |designer|
    discoverable_by(designer)
      .joins(:spots).where(spots: { designer: designer })
      .left_joins(active_nda: :designer_ndas).where("(projects.project_type = 'contest' AND (ndas.nda_type = 2 OR designer_ndas.designer_id = #{designer.id})) OR projects.project_type = 'one_to_one'")
  }

  scope :discoverable, lambda {
    where(discoverable: true)
  }

  scope :by_active_nda, lambda { |nda|
    joins(brand_dna: { brand: :active_nda }).where(ndas: { nda_type: nda == 'yes' ? [:standard, :custom] : :free })
  }

  scope :by_client, lambda { |client_id|
    joins(brand_dna: { brand: { company: :clients } }).where('clients.id = ?', client_id)
  }

  aasm :abandoned_cart_reminder_step, column: :abandoned_cart_reminder_step do
    state :first_reminder, initial: true
    state :second_reminder
    state :third_reminder
    state :reminding_completed

    event :send_next_reminder do
      before do
        Projects::AbandonedCartReminders::Send.new(self).call
      end

      transitions from: :first_reminder, to: :second_reminder, guard: :first_reminder?
      transitions from: :second_reminder, to: :third_reminder, guard: :second_reminder?
      transitions from: :third_reminder, to: :reminding_completed, guard: :third_reminder?
    end
  end

  aasm column: :state do
    state :draft, initial: true
    state :design_stage
    state :finalist_stage
    state :files_stage
    state :review_files
    state :completed
    state :canceled
    state :error

    # event :finish_brand_examples do
    #   transitions from: :draft, to: :waiting_for_style_details
    # end

    # event :finish_packaging_measurements do
    #   transitions from: :draft, to: :waiting_for_style_details
    # end

    # event :finish_style_details do
    #   transitions from: :waiting_for_style_details, to: :waiting_for_audience_details, if: :need_first_step?
    #   transitions from: :draft, to: :waiting_for_audience_details, unless: :need_first_step?
    # end

    # event :finish_audience_details do
    #   transitions from: :waiting_for_audience_details, to: :waiting_for_finish_details
    # end

    # event :finish_public_steps do
    #   transitions from: :waiting_for_finish_details, to: :waiting_for_details
    # end

    # event :finish_details do
    #   transitions from: :waiting_for_details, to: :waiting_for_checkout
    # end

    #   transitions from: :waiting_for_checkout, to: :design_stage, unless: :brand_identity?
    #   transitions from: :waiting_for_checkout, to: :waiting_for_stationery_details, if: :brand_identity?
    # end

    # event :select_bank_transfer do
    #   transitions from: :waiting_for_checkout, to: :waiting_for_payment, unless: :brand_identity?
    #   transitions from: :waiting_for_checkout, to: :waiting_for_payment_and_stationery_details, if: :brand_identity?
    # end

    # event :approve_bank_transfer do
    #   after do
    #     if design_stage?
    #       broadcast(:bank_transfer_payment_received, self)
    #       Projects::SetStageTime.new(self, :design_stage).call
    #     end
    #   end

    #   transitions from: :waiting_for_payment, to: :design_stage
    #   transitions from: :waiting_for_payment_and_stationery_details, to: :waiting_for_stationery_details
    # end

    # event :filled_stationery do
    #   after do
    #     if design_stage?
    #       broadcast(:payment_received, self)
    #       Projects::SetStageTime.new(self, :design_stage).call
    #     end
    #   end

    #   transitions from: :waiting_for_payment_and_stationery_details, to: :waiting_for_payment
    #   transitions from: :waiting_for_stationery_details, to: :design_stage
    # end

    event :finish_creation do
      after do
        if design_stage?
          Projects::SetStageTime.new(self, :design_stage).call

          broadcast(:one_to_one_project_started, self) if one_to_one?
        end
      end

      transitions from: :draft, to: :design_stage
    end

    event :finalist_stage do
      after do
        Projects::SetStageTime.new(self, :finalist_stage).call

        broadcast(:finalist_stage_started, self) if contest?
      end

      transitions from: :design_stage, to: :finalist_stage, guard: :finalist_count_enough_for_finalist_stage?
    end

    event :select_winner do
      after do
        Projects::SetStageTime.new(self, :files_stage).call

        broadcast(:files_stage_started, self) if contest?
        broadcast(:design_approved, self) if one_to_one?
      end

      transitions from: :finalist_stage, to: :files_stage
    end

    event :upload_files do
      after do
        Projects::SetStageTime.new(self, :review_files_stage).call
      end

      transitions from: :files_stage, to: :review_files
    end

    event :approve_files do
      after do
        broadcast(:contest_completed, self) if contest?
        broadcast(:all_done, self) if one_to_one?
      end

      transitions from: :review_files, to: :completed
    end

    event :cancel do
      # TODO: only admin
      transitions to: [:canceled]
    end

    event :error do
      before do
        broadcast(:expire_project, self)
      end

      # TODO: no designers within 7 days
      # no designs within 7 days
      # client not responding
      transitions to: [:error]
    end
  end

  def brand_identity?
    product.key == 'brand-identity'
  end

  def website?
    product.key == 'website'
  end

  def website_banner?
    product.key == 'website-banner'
  end

  def name
    self[:name] || (brand_dna&.name ? "#{brand_dna&.name} - #{product&.name}" : product&.name)
  end

  def finalist_count_enough_for_finalist_stage?
    finalists.count >= MIN_COUNT_OF_FINALISTS
  end

  def all_finalists_selected?
    spots.finalist_states.count == MAX_COUNT_OF_FINALISTS
  end

  def finish_at
    # TODO: do not hardcode (take from admin)
    # TODO: created_at? started_at
    # probably used nowhere, need to research and remove
    created_at + 7.days
  end

  def finalists
    designers.joins(:spots).merge(Spot.finalist_states)
  end

  def non_finalists
    designers.joins(:spots).merge(Spot.where(state: [Spot::STATE_DESIN_UPLOADED, Spot::STATE_ELIMINATED]))
  end

  def winner
    designers.joins(:spots).merge(Spot.winner).first
  end

  def winner_design
    spots.winner.first
  end

  def spots_available
    max_spots_count - spots.visible.count
  end

  def has_available_spot_for?(designer)
    spots_available.positive? && is_not_reserved_or_has_design_by?(designer) && !is_blocked?(designer)
  end

  def queue_available_for?(designer)
    !has_in_queue?(designer) && is_not_reserved_or_has_design_by?(designer)
  end

  def can_be_reserved_by?(designer)
    has_available_spot_for?(designer) || queue_available_for?(designer)
  end

  def designers_in_queue_count
    spots.in_queue.count
  end

  def reserved_by(designer)
    spots.visible.where(designer: designer)
  end

  def available_spots_reserved?(designer)
    reserved_by(designer).count >= MAX_SPOTS_COUNT_RESERVED_BY_DESIGNER
  end

  def project_type_price
    BigDecimal(full_price.to_s)
  end

  def upgrade_to_brand_identity!
    brand_identity_product = Product.find_by!(key: 'brand-identity')
    self.product = brand_identity_product
    save!
  end

  def has_in_queue?(designer)
    spots.in_queue.exists?(designer: designer)
  end

  def can_be_reserved?
    AVAILABLE_RESERVE_STATES.include?(state)
  end

  def is_blocked?(designer)
    return false unless company

    company.clients.joins(:designer_client_blocks).where(designer_client_blocks: { designer: designer }).any?
  end

  def nda_price
    active_nda.present? && !active_nda.paid? ? active_nda.price : 0
  end

  def need_first_step?
    ['logo', 'brand-identity', 'packaging'].include?(product.key)
  end

  def self.ransackable_scopes(*args)
    super(*args) + ['by_active_nda', 'by_client']
  end

  # refactored price calculation

  def additional_designs_price
    additional_price = product.additional_design_prices.detect { |price| price.quantity == max_spots_count }

    additional_price&.amount || Money.new(0)
  end

  def additional_screens_price
    additional_price = product.additional_screen_prices.detect { |price| price.quantity == max_screens_count }

    additional_price&.amount || Money.new(0)
  end

  def additional_time_price
    additional_days * Money.from_amount(ADDITIONAL_TIME_PRICE_PER_DAY)
  end

  def full_price
    (one_to_one? ? product.one_to_one_price : (product.price + additional_designs_price)) + additional_screens_price + additional_time_price
  end

  def email_template_set_name
    id.odd? ? 'a' : 'b'
  end

  private

  def is_not_reserved_or_has_design_by?(designer)
    !is_reserved_by?(designer) || has_design_by?(designer)
  end

  def is_reserved_by?(designer)
    spots.reserved.exists?(designer: designer)
  end

  def has_design_by?(designer)
    spots.joins([:designer, :design]).exists?(designers: { id: designer })
  end

  def manual?
    product&.key == 'manual'
  end

  PUBLIC_STATES = [
    STATE_DRAFT
  ].map(&:to_s)

  BEFORE_PAYMENT_STATES = [
    STATE_DRAFT
  ].map(&:to_s)

  UNFINISHED_STATES = [
    STATE_DRAFT
  ].map(&:to_s)

  NOT_ALLOWED_FOR_RECEIPT_GENERATION_STATES = [
    STATE_DRAFT
  ].map(&:to_s)

  DESIGNER_IN_PROGRESS_STATES = [
    STATE_DESIGN_STAGE,
    STATE_FINALIST_STAGE,
    STATE_FILES_STAGE,
    STATE_REVIEW_FILES
  ].map(&:to_s)

  DESIGNER_COMPLETED_STATES = [
    STATE_COMPLETED
  ].map(&:to_s)

  DESIGNER_CAN_UPDATE_STATES = [
    STATE_DESIGN_STAGE
  ].map(&:to_s)

  DESIGNER_CAN_READ_STATES = [
    STATE_DESIGN_STAGE,
    STATE_FINALIST_STAGE,
    STATE_FILES_STAGE,
    STATE_REVIEW_FILES,
    STATE_COMPLETED
  ].map(&:to_s)

  CLIENT_CAN_DESTROY_STATES = [
    STATE_DRAFT
  ].map(&:to_s)

  CLIENT_CAN_UPDATE_STATES = [
    STATE_DRAFT,
    STATE_REVIEW_FILES
  ].map(&:to_s)

  AVAILABLE_RESERVE_STATES = [
    STATE_DESIGN_STAGE
  ].map(&:to_s)

  DISCOVER_STATES = [
    STATE_DESIGN_STAGE,
    STATE_FINALIST_STAGE,
    STATE_FILES_STAGE,
    STATE_REVIEW_FILES,
    STATE_COMPLETED
  ].map(&:to_s)

  REMINDER_ACTIVE_STATES = [
    STATE_FIRST_REMINDER,
    STATE_SECOND_REMINDER,
    STATE_THIRD_REMINDER
  ].map(&:to_s)
end
