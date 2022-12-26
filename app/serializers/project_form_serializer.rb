# frozen_string_literal: true

class ProjectFormSerializer < ActiveModel::Serializer
  attributes :id,
             :brand_dna_bold_or_refined,
             :brand_dna_detailed_or_clean,
             :brand_dna_handcrafted_or_minimalist,
             :brand_dna_low_income_or_high_income,
             :brand_dna_masculine_or_premium,
             :brand_dna_outmoded_actual,
             :brand_dna_serious_or_playful,
             :brand_dna_stand_out_or_not_from_the_crowd,
             :brand_dna_target_country_codes,
             :brand_dna_traditional_or_modern,
             :brand_dna_value_or_premium,
             :brand_dna_youthful_or_mature,
             :brand_additional_text,
             :brand_background_story,
             :brand_description,
             :brand_name,
             :brand_slogan,
             :brand_what_is_special,
             :brand_where_it_is_used,
             :company_company_name,
             :company_country_code,
             :company_vat,
             :colors_comment,
             :ideas_or_special_requirements,
             :max_spots_count,
             :product_id,
             :product_key,
             :product_size,
             :product_text,
             :stock_images_exist,
             :upgrade_package,
             :what_is_it_for,
             :packaging_measurements,
             :packaging_type,
             :current_step,
             :max_screens_count,
             :project_type,
             :source_files_shared,
             :has_existing_designs,
             :discount_code,
             :additional_days,
             :normalized_price

  belongs_to :product
  belongs_to :current_step

  belongs_to :brand
  belongs_to :brand_dna

  belongs_to :discount

  has_many :bad_brand_examples do
    object.bad_brand_examples.includes(:brand_example)
  end

  has_many :good_brand_examples do
    object.good_brand_examples.includes(:brand_example)
  end

  has_many :skip_brand_examples do
    object.skip_brand_examples.includes(:brand_example)
  end

  has_many :additional_documents
  has_many :stock_images
  has_many :existing_designs
  has_many :inspirations
  has_many :colors

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

  def has_existing_designs
    has_logo_source_files? || has_existing_designs?
  end

  def has_logo_source_files?
    last_logo_project = object.brand.projects.completed.joins(:product).where(products: { key: 'logo' }).order(created_at: :desc).first
    last_logo_project && last_logo_project.project_source_files.count.positive?
  end

  def has_existing_designs?
    object.existing_designs.count.positive?
  end
end
