# frozen_string_literal: true

ActiveAdmin.register Project do
  menu if: proc { authorized?(:manage, Project) }

  scope 'Active', :all, default: true
  scope('Deleted') { |scope| scope.with_discarded.discarded }

  permit_params :name,
                :description,
                :debrief,
                :visible,
                :creator_id,
                :brand_dna_id,
                :project_type,
                :state,
                :price,
                :packaging_measurements_type,
                :design_stage_started_at,
                :finalist_stage_started_at,
                :files_stage_started_at,
                :review_files_stage_started_at,
                :design_stage_expires_at,
                :finalist_stage_expires_at,
                :files_stage_expires_at,
                :review_files_stage_expires_at,
                :ideas_or_special_requirements,
                :max_spots_count,
                :block_designer_available,
                :eliminate_designer_available,
                :manual_product_category_id,
                :product_id,
                :product_text,
                :what_is_it_for,
                :product_size,
                :stock_images_exist,
                :discoverable,
                :max_screens_count,
                brand_dna_attributes: [
                  :id,
                  :bold_or_refined,
                  :detailed_or_clean,
                  :handcrafted_or_minimalist,
                  :low_income_or_high_income,
                  :masculine_or_premium,
                  :outmoded_actual,
                  :serious_or_playful,
                  :stand_out_or_not_from_the_crowd,
                  :traditional_or_modern,
                  :value_or_premium,
                  :youthful_or_mature,
                  target_country_codes: []
                ],
                brand_attributes: [
                  :id,
                  :name,
                  :slogan,
                  :additional_text,
                  :description,
                  :background_story,
                  :where_it_is_used,
                  :what_is_special,
                  competitors_attributes: [
                    :id,
                    :brand_id,
                    :name,
                    :website,
                    :comment,
                    :rate,
                    :_destroy,
                    competitor_logo_attributes: [
                      :id,
                      :file
                    ]
                  ]
                ],
                inspirations_attributes: [
                  :id,
                  :comment,
                  :_destroy,
                  inspiration_image_attributes: [
                    :id,
                    :file
                  ]
                ],
                existing_designs_attributes: [
                  :id,
                  :comment,
                  :_destroy,
                  existing_logo_attributes: [
                    :id,
                    :file
                  ]
                ],
                additional_documents_attributes: [
                  :id,
                  :comment,
                  :_destroy,
                  additional_document_attributes: [
                    :id,
                    :file
                  ]
                ],
                stock_images_attributes: [
                  :id,
                  :comment,
                  :_destroy,
                  stock_image_attributes: [
                    :id,
                    :file
                  ]
                ],
                spots_attributes: [
                  :id,
                  :designer_id,
                  :reserved_state_started_at,
                  :state,
                  :_destroy
                ]

  actions :index, :show, :new, :create, :edit, :update, :destroy

  includes :payments,
           :active_spots,
           :eliminated_spots,
           :expired_spots,
           :busy_spots,
           :spots_with_uploaded_design,
           :current_step,
           :discount, {
             product: :additional_design_prices
           }, {
             brand_dna: {
               brand: :active_nda
             }
           }, {
             spots: :design
           },
           company: {
             clients: :user
           }

  attrs = [
    :id,
    :name,
    :state,
    :visible,
    :current_step_path,
    :product_key,
    :project_type,
    :created_at,
    :updated_at,
    :upgrade_package,
    :normalized_price,
    :packaging_measurements_type,
    :packaging_measurements_id,
    :what_to_design,
    :design_type,
    :back_business_card_details,
    :front_business_card_details,
    :compliment,
    :letter_head,
    :colors_comment,
    :design_stage_started_at,
    :design_stage_expires_at,
    :finalist_stage_started_at,
    :finalist_stage_expires_at,
    :files_stage_started_at,
    :files_stage_expires_at,
    :review_files_stage_started_at,
    :review_files_stage_expires_at,
    :ideas_or_special_requirements,
    :discoverable,
    :debrief
  ]

  index do
    selectable_column
    column :id
    column :name
    column :state
    column :visible
    column :current_step_path

    tag_column 'Product', :product_key
    tag_column 'Type', :project_type

    column :clients do |project|
      project.company&.clients&.map do |client|
        link_to client.id, [ActiveAdmin.application.default_namespace, client]
      end
    end

    column :company do |project|
      project.company&.company_name
    end

    column I18n.t('active_admin.payment_type') do |project|
      project.payments.first&.payment_type
    end

    column 'Spots sold', :max_spots_count

    column 'Empty spots' do |project|
      project.max_spots_count - project.busy_spots.length
    end

    column 'Active designs' do |project|
      project.active_spots.length
    end

    column 'Total design uploaded' do |project|
      project.spots_with_uploaded_design.length
    end

    column 'Days left in stage' do |project|
      if project.review_files?
        (project.review_files_stage_expires_at.to_date - Time.current.to_date).to_i
      elsif ['design_stage', 'finalist_stage', 'files_stage'].include?(project.state)
        (project.public_send("#{project.state}_expires_at").to_date - Time.current.to_date).to_i
      end
    end

    column 'Designs eliminated' do |project|
      project.eliminated_spots.length
    end

    column 'Spots expired' do |project|
      project.expired_spots.length
    end

    column 'Price paid' do |project|
      project.payments.first&.amount
    end

    column :payment_at do |project|
      project.payments.first&.created_at
    end

    column 'VAT paid' do |project|
      project.payments.first&.vat_price_paid&.nonzero?
    end

    column 'Project price' do |project|
      if project.discount
        project.project_type_price - project.discount.monetize(project.project_type_price)
      else
        project.project_type_price
      end
    end

    column 'NDA type' do |project|
      nda_type = project.brand_dna.brand.active_nda&.nda_type
      nda_type if ['standard', 'custom'].include?(nda_type)
    end

    column 'NDA price' do |project|
      if project.discount&.percent? && project.payments.first&.nda_price_paid
        project.payments.first.nda_price_paid - project.discount.monetize(project.payments.first.nda_price_paid)
      elsif project.payments.first&.nda_price_paid
        project.payments.first.nda_price_paid.nonzero?
      end
    end

    column :created_at
    column :discoverable

    bool_column :deleted, &:discarded?

    actions
  end

  show do
    attributes_table do
      attrs.each do |atr|
        row atr
      end

      row :clients do |project|
        project.company&.clients&.map do |client|
          link_to client.email, [ActiveAdmin.application.default_namespace, client]
        end
      end

      row I18n.t('active_admin.payment_type') do |project|
        project.payments.first&.payment_type
      end

      row :payment_at do |project|
        project.payments.first&.created_at
      end
    end

    panel 'Brand DNA' do
      attributes_table_for project.brand_dna do
        row :id
        row :bold_or_refined
        row :detailed_or_clean
        row :handcrafted_or_minimalist
        row :low_income_or_high_income
        row :masculine_or_premium
        row :outmoded_actual
        row :serious_or_playful
        row :stand_out_or_not_from_the_crowd
        row :traditional_or_modern
        row :value_or_premium
        row :youthful_or_mature
        row :target_country_codes
      end
    end

    panel 'Brand' do
      attributes_table_for project.brand do
        row :id
        row :name
        row :slogan
        row :additional_text
        row :description
        row :background_story
        row :where_it_is_used
        row :what_is_special
      end
    end

    panel 'Competitors' do
      table_for project.brand.competitors do
        column :name
        column :website
        column :comment
        column :rate

        column :image do |competitor|
          image(competitor.competitor_logo.file, :small)
        end
      end
    end

    panel 'Inspirations' do
      table_for project.inspirations do
        column :comment

        column :image do |inspiration|
          image(inspiration.inspiration_image&.file, :small)
        end
      end
    end

    panel 'Existing Designs' do
      table_for project.existing_designs do
        column :comment

        column :image do |existing_design|
          image(existing_design.existing_logo.file, :small)
        end
      end
    end

    if project.product.packaging?
      panel 'Additional Documents' do
        table_for project.additional_documents do
          column :comment

          column :image do |additional_document|
            image(additional_document.additional_document.file, :small)
          end
        end
      end
    end

    if project.product.logo? || project.product.brand_identity?
      panel 'Bad brand examples' do
        div class: 'main-row' do
          project.bad_brand_examples.each do |example|
            div class: 'main-col-3' do
              div image(example.brand_example.file, :small)
            end
          end
        end
      end

      panel 'Good brand examples' do
        div class: 'main-row' do
          project.good_brand_examples.each do |example|
            div class: 'main-col-3' do
              div image(example.brand_example.file, :small)
            end
          end
        end
      end

      panel 'Skip brand examples' do
        div class: 'main-row' do
          project.skip_brand_examples.each do |example|
            div class: 'main-col-3' do
              div image(example.brand_example.file, :small)
            end
          end
        end
      end
    end
  end

  form do |f|
    semantic_errors

    if f.object.persisted?
      inputs do
        input :name
        input :state
        input :visible
        input :normalized_price
        input :normalized_type_price
        input :packaging_measurements_type
        input :design_stage_started_at
        input :design_stage_expires_at
        input :finalist_stage_started_at
        input :finalist_stage_expires_at
        input :files_stage_started_at
        input :files_stage_expires_at
        input :review_files_stage_started_at
        input :review_files_stage_expires_at
        input :ideas_or_special_requirements

        input :product_text
        input :what_is_it_for
        input :product_size
        input :stock_images_exist, as: :radio, collection: Project.stock_images_exists.keys.map { |k| [k.humanize, k] }
        input :discoverable, as: :boolean
      end

      inputs 'Brand DNA', for: [:brand_dna, project.brand_dna || BrandDna.new] do |b|
        b.input :bold_or_refined
        b.input :detailed_or_clean
        b.input :handcrafted_or_minimalist
        b.input :low_income_or_high_income
        b.input :masculine_or_premium
        b.input :outmoded_actual
        b.input :serious_or_playful
        b.input :stand_out_or_not_from_the_crowd
        b.input :traditional_or_modern
        b.input :value_or_premium
        b.input :youthful_or_mature
        b.input :target_country_codes, as: :select, multiple: true, include_hidden: false, collection: ISO3166::Country.all.sort_by(&:name).map { |c| ["#{c.name} (#{c.alpha2})", c.alpha2] }
      end

      inputs 'Brand', for: [:brand, project.brand || Brand.new] do |b|
        b.input :name
        b.input :slogan
        b.input :additional_text
        b.input :description, as: :text
        b.input :background_story
        b.input :where_it_is_used
        b.input :what_is_special

        inputs do
          b.has_many :competitors, new_record: 'Add competitor', allow_destroy: true do |t|
            t.object.build_competitor_logo unless t.object.competitor_logo

            t.input :name
            t.input :website
            t.input :comment
            t.input :rate

            t.has_many :competitor_logo, new_record: false do |c|
              c.input :file, hint: c.template.image(c.object&.file, :small)
            end
          end
        end
      end

      inputs do
        has_many :inspirations, new_record: 'Add inspiration', allow_destroy: true do |t|
          t.object.build_inspiration_image unless t.object.inspiration_image

          t.input :comment

          t.has_many :inspiration_image, new_record: false do |i|
            i.input :file, hint: i.template.image(i.object&.file, :small)
          end
        end
      end

      inputs do
        has_many :existing_designs, new_record: 'Add Existing design', allow_destroy: true do |t|
          t.object.build_existing_logo unless t.object.existing_logo

          t.input :comment

          t.has_many :existing_logo, new_record: false do |e|
            e.input :file, hint: e.template.image(e.object&.file, :small)
          end
        end
      end

      inputs do
        has_many :additional_documents, new_record: 'Add additional document', allow_destroy: true do |t|
          t.object.build_additional_document unless t.object.additional_document

          t.input :comment

          t.has_many :additional_document, new_record: false do |b|
            b.input :file, hint: b.template.image(b.object&.file, :small)
          end
        end
      end

      inputs do
        has_many :stock_images, new_record: 'Add stock image', allow_destroy: true do |t|
          t.object.build_stock_image unless t.object.stock_image

          t.input :comment

          t.has_many :stock_image, new_record: false do |b|
            b.input :file, hint: b.template.image(b.object&.file, :small)
          end
        end
      end

    else

      inputs do
        f.object.design_stage_started_at = DateTime.now
        f.object.design_stage_expires_at = DateTime.now + Product.find_by(key: 'manual').contest_design_stage_expire_days.days

        input :product_id, as: :select, collection: Product.order(:name), input_html: { class: 'select2' }

        input :brand_dna_id, as: :select, collection: BrandDna.includes(brand: :company).all.order(:id).map { |dna|
          [
            truncate("Brand DNA ID: #{dna.id}. Brand ID: #{dna.brand.id}. Brand name: #{dna.brand.name}. Company ID: #{dna.brand.company&.id}. Company name: #{dna.brand.company&.name}", length: 200),
            dna.id
          ]
        }, input_html: { class: 'select2' }

        input :creator_id, as: :select, collection: Client.all.map { |client|
          ["#{client.name} (##{client.id})", client.id]
        }, input_html: { class: 'select2' }

        input :project_type, label: 'Type', as: :select, collection: Project.project_types.keys.map { |type|
          [type.humanize, type]
        }, input_html: { class: 'select2' }

        input :name
        input :ideas_or_special_requirements

        input :max_spots_count

        input :price, as: :number

        input :design_stage_started_at
        input :design_stage_expires_at
        input :finalist_stage_started_at
        input :finalist_stage_expires_at
        input :files_stage_started_at
        input :files_stage_expires_at
        input :review_files_stage_started_at
        input :review_files_stage_expires_at

        input :block_designer_available
        input :eliminate_designer_available
        input :discoverable

        input :manual_product_category_id, label: 'Designer product category', as: :select, collection: ProductCategory.all.map { |category|
          [category.name, category.id]
        }, input_html: { class: 'select2' }

        input :state, input_html: { value: 'design_stage', readonly: true }
        input :visible
      end

      inputs do
        has_many :inspirations, new_record: 'Add inspiration', allow_destroy: true do |t|
          t.object.build_inspiration_image unless t.object.inspiration_image

          t.input :comment

          t.has_many :inspiration_image, new_record: false do |i|
            i.input :file, hint: i.template.image(i.object&.file, :small)
          end
        end
      end

      inputs do
        has_many :additional_documents, new_record: 'Add additional document', allow_destroy: true do |t|
          t.object.build_additional_document unless t.object.additional_document

          t.input :comment

          t.has_many :additional_document, new_record: false do |b|
            b.input :file, hint: b.template.image(b.object&.file, :small)
          end
        end
      end

      inputs do
        has_many :spots, new_record: 'Add spot', allow_destroy: true do |t|
          t.object.reserved_state_started_at = DateTime.now

          t.input :designer_id, as: :select, collection: Designer.all.map { |designer|
            ["#{designer.name} (##{designer.id})", designer.id]
          }, input_html: { class: 'select2' }
          t.input :state, input_html: { value: 'reserved', readonly: true }
          t.input :reserved_state_started_at
        end
      end
    end

    actions
  end

  controller do
    def create
      # inspirations_attributes = params[:project][:inspirations_attributes]

      # brand_attributes = ActionController::Parameters.new(
      #   brand: {
      #     inspirations_attributes: inspirations_attributes
      #   }
      # ).require(:brand).permit(
      #   inspirations_attributes: [
      #     :id,
      #     :comment,
      #     :_destroy,
      #     inspiration_image_attributes: [
      #       :id,
      #       :file
      #     ]
      #   ]
      # )

      super

      @project.update(design_stage_started_at: DateTime.now) unless @project.design_stage_started_at
      @project.update(design_stage_expires_at: DateTime.now + @project.product.design_stage_expire_days.days) unless @project.design_stage_expires_at
      @project.update(normalized_type_price: @project.normalized_price)
      # @project.brand.update(brand_attributes)
    end
  end

  filter :id
  filter :name
  filter :brand_id_eq, label: 'Brand', as: :select, collection: lambda {
    Brand.order(:name).map { |brand| ["#{brand.name} (ID: #{brand.id})", brand.id] }
  }, input_html: { class: 'select2' }
  filter :state, as: :string, filters: [:contains, :not_cont, :equals, :starts_with, :ends_with]
  filter :project_type_eq, label: 'Type', as: :select, collection: lambda {
    Project.project_types.keys.map { |type| [type.humanize, type] }
  }, input_html: { class: 'select2' }
  filter :by_client, label: 'Client ID', as: :string

  filter :created_at
  filter :target_country_codes
  filter :slogan
  filter :upgrade_package
  filter :normalized_price

  csv do
    attrs.each do |atr|
      column atr
    end

    column :clients do |project|
      project.company&.clients&.map(&:id)&.join(', ')
    end

    column :company do |project|
      project.company&.company_name
    end

    column I18n.t('active_admin.payment_type') do |project|
      project.payments.first&.payment_type
    end

    column 'Spots sold', &:max_spots_count

    column 'Empty spots' do |project|
      project.max_spots_count - project.busy_spots.length
    end

    column 'Active designs' do |project|
      project.active_spots.length
    end

    column 'Total design uploaded' do |project|
      project.spots_with_uploaded_design.length
    end

    column 'Days left in stage' do |project|
      if project.review_files?
        (project.review_files_stage_expires_at.to_date - Time.current.to_date).to_i
      elsif ['design_stage', 'finalist_stage', 'files_stage'].include?(project.state)
        (project.public_send("#{project.state}_expires_at").to_date - Time.current.to_date).to_i
      end
    end

    column 'Designs eliminated' do |project|
      project.eliminated_spots.length
    end

    column 'Spots expired' do |project|
      project.expired_spots.length
    end

    column 'Price paid' do |project|
      project.payments.first&.amount
    end

    column :payment_at do |project|
      project.payments.first&.created_at
    end

    column 'VAT paid' do |project|
      project.company ? VatCalculator.new(project).call : 0
    end

    column 'Project price' do |project|
      if project.discount
        project.project_type_price - project.discount.monetize(project.project_type_price)
      else
        project.project_type_price
      end
    end

    column 'NDA type' do |project|
      nda_type = project.brand_dna.brand.active_nda&.nda_type
      nda_type if ['standard', 'custom'].include?(nda_type)
    end

    column 'NDA price' do |project|
      if project.discount&.percent? && project.payments.first&.nda_price_paid
        project.payments.first.nda_price_paid - project.discount.monetize(project.payments.first.nda_price_paid)
      elsif project.payments.first&.nda_price_paid
        project.payments.first.nda_price_paid.nonzero?
      end
    end
  end
end
