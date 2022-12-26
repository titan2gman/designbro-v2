# frozen_string_literal: true

class ProjectBaseSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :product_id,
             :product_key,
             :brand_id,
             :brand_dna_id,
             :state,
             :price,
             :winner,
             :designs,
             :finish_at,
             :finalists,
             :designers,
             :compliment,
             :description,
             :design_type,
             :letter_head,
             :winner_prize,
             :designs_count,
             :discount_code,
             :my_spots_count,
             :invoice_number,
             :what_to_design,
             :what_is_it_for,
             :packaging_type,
             :colors_comment,
             :spots_available,
             :upgrade_package,
             :can_be_reserved,
             :max_spots_count,
             :files_stage_expires_at,
             :packaging_measurements,
             :max_count_of_finalists,
             :design_stage_expires_at,
             :designers_in_queue_count,
             :finalist_stage_expires_at,
             :back_business_card_details,
             :front_business_card_details,
             :review_files_stage_expires_at,
             :ideas_or_special_requirements,
             :created_at,
             :product_text,
             :product_size,
             :reservation_expire_days,
             :block_designer_available,
             :eliminate_designer_available,
             :max_screens_count,
             :project_type,
             :source_files_shared,
             :current_step_path,
             :additional_days,
             :new_colors

  belongs_to :product
  belongs_to :brand_dna
  belongs_to :company
  belongs_to :discount

  has_many :brand_examples do
    object.brand_examples.includes(:brand_example)
  end

  has_many :additional_documents
  has_many :stock_images
  has_many :competitors
  has_many :inspirations
  has_many :existing_designs
  has_one :featured_image

  has_many :bad_brand_examples do
    object.bad_brand_examples.includes(:brand_example)
  end
  has_many :good_brand_examples do
    object.good_brand_examples.includes(:brand_example)
  end
  has_many :skip_brand_examples do
    object.skip_brand_examples.includes(:brand_example)
  end

  has_many :new_brand_examples, serializer: NewBrandExampleSerializer

  has_many :colors

  has_many :spots do
    object.spots.visible.includes(
      designer: [:user, :portfolio_works],
      design: [:project, :designer, :uploaded_file]
    )
  end

  def description
    object.description || object.brand.description
  end

  def designs
    object.designs.not_eliminated
  end

  def designs_count
    object.spots_with_uploaded_design.length
  end

  def designers
    # TODO: is it right?
    object.designers.count
  end

  def my_spots_count
    user = view_context.current_api_v1_user
    object.reserved_by(user.designer).count if user&.designer?
  end

  def can_be_reserved
    designer = view_context.current_api_v1_user&.designer
    object.can_be_reserved_by?(designer)
  end

  def winner
    object.winner.try(:id).to_s
  end

  def finalists
    object.finalists.ids.map(&:to_s)
  end

  def invoice_number
    object.payments&.first&.payment_id || ''
  end

  def max_count_of_finalists
    Project::MAX_COUNT_OF_FINALISTS
  end

  def packaging_measurements
    return unless object.packaging_measurements

    packaging_measurements = object.packaging_measurements

    hash = packaging_measurements.attributes.slice(
      'label_height',
      'label_width',
      'front_height',
      'front_width',
      'side_depth',
      'diameter',
      'volume',
      'height',
      'width'
    )

    technical_drawing = packaging_measurements.technical_drawing

    hash.merge(
      technical_drawing_id: technical_drawing&.id,
      technical_drawing_url: technical_drawing&.file&.url,
      filename: technical_drawing&.original_filename,
      file_extension: technical_drawing&.file&.file&.extension,
      filesize: technical_drawing&.file&.file&.size.to_f / (1024 * 1024)
    )
  end
end
