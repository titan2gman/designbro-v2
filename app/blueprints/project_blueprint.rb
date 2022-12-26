# frozen_string_literal: true

class ProjectBlueprint < Blueprinter::Base
  identifier :id

  fields :brand_name

  field :brand_example_ids do |project|
    project.new_brand_examples.map(&:example_id)
  end

  view :project_builder do
    fields(
      :current_step_path,
      :current_step_component_name,
      :brand_dna_traditional_or_modern,
      :brand_dna_value_or_premium,
      :brand_dna_bold_or_refined,
      :brand_dna_detailed_or_clean,
      :brand_dna_handcrafted_or_minimalist,
      :brand_dna_serious_or_playful,
      :brand_dna_stand_out_or_not_from_the_crowd,
      :brand_dna_low_income_or_high_income,
      :brand_dna_masculine_or_premium,
      :brand_dna_youthful_or_mature,
      :brand_dna_target_country_codes,
      :brand_additional_text,
      :brand_description,
      :ideas_or_special_requirements,
      :new_colors,
      :colors_comment,
      :upgrade_package,
      :max_spots_count,
      :max_screens_count,
      :discount_code,
      :stripe_session_id,
      :normalized_price
    )

    field :nda_type do |project|
      project.active_nda&.nda_type || 'free'
    end

    association :product, blueprint: ProductBlueprint, view: :project_builder
    association :discount, blueprint: DiscountBlueprint
    association :existing_designs, blueprint: ExistingDesignBlueprint, view: :project_builder
    association :competitors, blueprint: CompetitorBlueprint, view: :project_builder
    association :inspirations, blueprint: InspirationBlueprint, view: :project_builder
    association :additional_documents, blueprint: AdditionalDocumentBlueprint, view: :project_builder

    transform CamelCaseTransformer
  end
end
