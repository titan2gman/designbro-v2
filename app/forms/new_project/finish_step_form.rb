# frozen_string_literal: true

module NewProject
  class FinishStepForm < NewProject::StepBaseForm
    presents :project

    attribute :client, Object

    attribute :colors_exist, Boolean
    attribute :competitors_exist, Boolean
    attribute :existing_designs_exist, Boolean
    attribute :inspirations_exist, Boolean
    attribute :source_files_shared, Boolean
    attribute :stock_images_exist, String

    attribute :additional_documents, Array
    attribute :competitors, Array
    attribute :existing_designs, Array
    attribute :inspirations, Array
    attribute :stock_images, Array

    attribute :colors, Array
    attribute :colors_comment, String, default: ''

    attribute :brand_additional_text, String
    attribute :brand_background_story, String
    attribute :brand_description, String
    attribute :brand_id, Integer
    attribute :brand_name, String
    attribute :brand_slogan, String
    attribute :brand_what_is_special, String
    attribute :brand_where_it_is_used, String

    attribute :ideas_or_special_requirements, String
    attribute :product_size, String
    attribute :product_text, String
    attribute :what_is_it_for, String

    validates :id, presence: true, if: :validate_form?

    # TODO: hotfix, need to display validation issues on the frontend side
    # validate :competitors_count, if: proc { validate_form? && competitors_exist }
    # validate :inspirations_count, if: proc { validate_form? && inspirations_exist }

    # validate :colors_count, if: :colors_exist
    # validate :existing_designs_count, if: :existing_designs_exist

    # logo, brand-identity

    # validates :description, presence: true, if: -> { validate_form? && (is_logo? || is_brand_identity?) }

    # packaging

    # validates :what_is_special,
    #           :where_it_is_used,
    #           :background_story, presence: true, if: -> { upgrade_project_state && is_packaging? }

    private

    def persist!
      update_related_entities

      project.reload

      attach_project_to_creator
      attach_brand_to_company

      update_brand

      update_project_attributes
      update_brand_attributes

      update_step
    end

    def update_related_entities
      colors_exist ? update_colors : destroy_colors
      existing_designs_exist ? update_existing_designs : destroy_existing_designs
      competitors_exist ? update_competitors : destroy_competitors
      inspirations_exist ? update_inspirations : destroy_inspirations
      stock_images_exist == 'yes' ? update_stock_images : destroy_stock_images

      update_additional_documents
    end

    def attach_brand_to_company
      project.brand.update(company: client.company) if client
    end

    def attach_project_to_creator
      project.update(creator: client) if client
    end

    def update_brand
      return unless client

      if new_brand? && !project.brand
        brand = client.company.brands.create!(name: brand_name)
        brand_dna = project.brand_dna.dup
        brand_dna.update!(brand: brand)
        project.update!(brand_dna: brand_dna)
      elsif brand_id
        brand = client.company.brands.find(brand_id)
        brand_dna = brand.brand_dnas.first_or_create!
        project.update(brand_dna: brand_dna)
      end
    end

    def update_project_attributes
      project.update!(
        colors_comment: colors_comment,
        ideas_or_special_requirements: ideas_or_special_requirements,
        product_size: product_size,
        product_text: product_text,
        stock_images_exist: stock_images_exist || 'no',
        what_is_it_for: what_is_it_for,
        source_files_shared: source_files_shared
      )
    end

    def update_brand_attributes
      brand = project.brand

      brand.update!(
        additional_text: brand_additional_text || brand.additional_text,
        background_story: brand_background_story || brand.background_story,
        description: brand_description || brand.description,
        name: brand_name || brand.name || default_brand_name,
        slogan: brand_slogan || brand.slogan,
        what_is_special: brand_what_is_special || brand.what_is_special,
        where_it_is_used: brand_where_it_is_used || brand.where_it_is_used
      )
    end

    def update_existing_designs
      existing_designs.each do |existing_logo|
        project_existing_logo = project.existing_designs.joins(:existing_logo)
                                       .where(uploaded_files: { id: existing_logo[:uploaded_file_id] })
                                       .first!

        success = project_existing_logo.update(
          existing_logo.slice(:comment)
        )

        record.errors.add(:existing_designs, :invalid) unless success
      end
    end

    def destroy_existing_designs
      project.existing_designs.destroy_all if project.existing_designs.any? && upgrade_project_state
    end

    def update_competitors
      competitors.delete_if(&:empty?).each do |competitor|
        brand_competitor = project.brand.competitors.joins(:competitor_logo)
                                  .where(uploaded_files: { id: competitor[:uploaded_file_id] })
                                  .first!

        success = CompetitorForm.new(
          competitor.slice(
            :comment,
            :website,
            :rate,
            :name
          ).merge(
            id: brand_competitor&.id,
            validate_form: validate_form?
          )
        ).save

        record.errors.add(:competitors, :invalid) unless success
      end
    end

    def destroy_competitors
      project.brand.competitors.destroy_all if project.brand.competitors.any? && upgrade_project_state
    end

    def update_inspirations
      inspirations.delete_if(&:empty?).each do |inspiration|
        project_inspiration = project.inspirations.joins(:inspiration_image)
                                     .where(uploaded_files: { id: inspiration[:uploaded_file_id] })
                                     .first!

        success = project_inspiration.update(
          inspiration.slice(:comment)
        )

        record.errors.add(:inspirations, :invalid) unless success
      end
    end

    def destroy_inspirations
      project.inspirations.destroy_all if project.inspirations.any? && upgrade_project_state
    end

    def update_stock_images
      stock_images.delete_if(&:empty?).each do |stock_image|
        project_stock_image = project.stock_images.joins(:stock_image)
                                     .where(uploaded_files: { id: stock_image[:uploaded_file_id] })
                                     .first!

        success = project_stock_image.update(
          stock_image.slice(:comment)
        )

        record.errors.add(:stock_images, :invalid) unless success
      end
    end

    def destroy_stock_images
      project.stock_images.destroy_all if project.stock_images.any? && upgrade_project_state
    end

    def update_colors
      project.colors = colors.map do |hex_color|
        project.colors.where(hex: hex_color).first_or_initialize
      end

      project.save
    end

    def destroy_colors
      return unless upgrade_project_state

      project.colors.destroy_all if project.colors.any?

      project.update(colors_comment: nil)
    end

    def update_additional_documents
      additional_documents.delete_if(&:empty?).each do |document|
        project_additional_document = project
                                      .additional_documents.joins(:additional_document)
                                      .where(uploaded_files: { id: document[:uploaded_file_id] })
                                      .first!

        success = project_additional_document.update(
          document.slice(:comment)
        )

        record.errors.add(:additional_documents, :invalid) unless success
      end
    end

    def existing_designs_count
      errors.add(:existing_designs, :have_items, min: 1, max: 4) if existing_designs.empty? || existing_designs.size > 4
    end

    def competitors_count
      errors.add(:competitors, :have_items, min: 1, max: 5) if competitors.empty? || competitors.size > 5
    end

    def inspirations_count
      errors.add(:inspirations, :have_items, min: 1, max: 3) if inspirations.empty? || inspirations.size > 3
    end

    def colors_count
      return unless colors.empty? && colors_comment.blank?

      errors.add(:colors, :have_items, min: 1, max: '∞')
      errors.add(:colors_comment, :blank)
    end

    def new_brand?
      !brand_id
    end

    def default_brand_name
      'Your brand'
    end
  end
end
