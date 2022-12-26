# frozen_string_literal: true

ActiveAdmin.register Designer do
  menu parent: 'User'

  scope 'Active', :all, default: true
  scope('Deleted') { |scope| scope.with_discarded.discarded }

  includes :designer_experiences, :user

  permit_params :display_name,
                :country_code,
                :first_name,
                :last_name,
                :gender,
                :age,
                :date_of_birth,
                :experience_english,
                :max_active_spots_count,
                :description,
                :badge,
                :visible,
                :one_to_one_available,
                :one_to_one_allowed,
                languages: [],
                avatar_attributes: [
                  :id,
                  :file
                ]

  member_action :approve_packaging, method: :put
  member_action :approve_brand_identity, method: :put

  member_action :disapprove_packaging, method: :put
  member_action :disapprove_brand_identity, method: :put

  collection_action :import, method: :post do
    unless params[:designers]
      notice = I18n.t('active_admin.designer.import.failure.file')
      return redirect_to [ActiveAdmin.application.default_namespace, :root], notice: notice
    end

    DesignerImporter.call(params[:designers])

    notice = I18n.t('active_admin.designer.import.success')
    redirect_to [ActiveAdmin.application.default_namespace, :root], notice: notice
  end

  csv do
    column :id
    column :email
    column :display_name
    column :first_name
    column :last_name

    column :description
    column :languages
    column :visible
    column :one_to_one_available
    column :one_to_one_allowed

    column :badge

    column :country_code
    column :age
    column :date_of_birth
    column :gender
    column :max_active_spots_count
    column :last_seen_at

    column :experience_english
    column :portfolio_uploaded

    column :address1
    column :address2
    column :city
    column :zip
    column :phone

    column :created_at
    column :updated_at
  end

  form do |_f|
    semantic_errors

    inputs do
      input :email
      input :password
      input :display_name
      input :first_name
      input :last_name
      input :description, input_html: { maxlength: 460 }
      input :languages, as: :select, multiple: true, collection: LANGUAGES.map { |l| [l[:name], l[:code]] }, include_hidden: false
      input :badge
      input :visible
      input :one_to_one_available
      input :one_to_one_allowed

      input :country_code
      input :age
      input :date_of_birth
      input :gender, include_blank: false
      input :experience_english, include_blank: false
      input :max_active_spots_count

      has_many :avatar, new_record: 'Add avatar', allow_destroy: true do |t|
        # t.object.build_avatar unless t.object.avatar

        t.input :file, hint: t.template.image(t.object&.file, :small)
      end
    end

    actions
  end

  index do
    selectable_column
    column :id

    column :avatar do |designer|
      image(designer.avatar&.file, :small)
    end

    column :email
    column :display_name
    column :first_name
    column :last_name

    column :description
    column :languages
    column :visible
    column :one_to_one_available
    column :one_to_one_allowed

    column :badge

    column :country_code
    column :age
    column :date_of_birth
    column :gender
    column :max_active_spots_count
    tag_column :state do |designer|
      if designer.designer_experiences.where(state: :pending).any?
        :pending
      elsif designer.designer_experiences.where(state: :approved).any?
        :approved
      elsif designer.designer_experiences.where(state: :disapproved).any?
        :disapproved
      else
        :draft
      end
    end

    column :last_seen_at

    tag_column :experience_english

    bool_column :deleted, &:discarded?

    actions
  end

  show do |designer|
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name

      row :description
      row :languages
      row :visible
      row :one_to_one_available
      row :one_to_one_allowed

      row :badge

      row :country_code
      row :age
      row :date_of_birth
      row :gender
      row :last_seen_at
      row :max_active_spots_count
      tag_row :experience_english

      tag_row :state do
        if designer.designer_experiences.where(state: :pending).any?
          :pending
        elsif designer.designer_experiences.where(state: :approved).any?
          :approved
        elsif designer.designer_experiences.where(state: :disapproved).any?
          :disapproved
        else
          :draft
        end
      end
    end

    panel 'Portfolio' do
      h3 'No works' if designer.portfolio_works.blank?

      designer.designer_experiences.where.not(experience: :no_experience).each do |experience|
        h3 experience.product_category.name, style: 'text-align: center'

        div class: 'main-row' do
          designer.portfolio_works.where(product_category_id: experience.product_category_id).each do |pw|
            div class: 'main-col-3' do
              div image(pw.uploaded_file&.file, :big)
              div pw.description
            end
          end
        end

        h4 "Current state: #{experience.state}"
        div class: 'main-row' do
          span button_to 'Approve', [:approve, ActiveAdmin.application.default_namespace, experience], method: :put if experience.pending?

          span button_to 'Disapprove', [:disapprove, ActiveAdmin.application.default_namespace, experience], method: :put if experience.pending? || experience.approved?
        end
      end
    end

    panel 'Reviews' do
      if designer.reviews.blank?
        h3 'No reviews'
      else
        table_for designer.reviews do
          column :id

          column :project

          tag_column :project_type do |review|
            review.project.project_type
          end

          column :client

          column :designer_rating
          column :designer_comment
          column :overall_rating
          column :overall_comment
        end
      end
    end
  end

  filter :display_name
  filter :first_name
  filter :last_name
  filter :country_code
  filter :age
  filter :date_of_birth
  filter :gender, as: :select, collection: [['male', 0], ['female', 1]]
  filter :experience_english, as: :select, collection: lambda {
    Designer.experience_englishes
  }
  filter :portfolio_uploaded
  filter :created_at
  filter :user_last_seen_at, as: :date_range
  filter :user_state, as: :string
  filter :designer_experiences_state_eq, label: 'Designer Experience State', as: :select, collection: lambda {
    DesignerExperience.pluck(:state).uniq.map { |name| [name, name] }
  }

  controller do
    def apply_filtering(chain)
      super(chain).distinct
    end

    def create
      password = params[:designer][:password]
      email = params[:designer][:email]
      user = User.new(uid: email, email: email, password: password, password_confirmation: password, state: 'active')
      @designer = user.build_designer(resource_params.first.merge(portfolio_uploaded: true))

      if user.valid?
        user.send_confirmation_instructions if @designer.save
      else
        @designer.valid?
        user.errors.each { |k, v| @designer.errors.add(k, v) }
      end

      respond_with @designer, location: -> { resource_path }
    end

    def update
      password = params[:designer][:password]
      email = params[:designer][:email]
      @designer = resource
      user = @designer.user
      user.update(email: email, uid: email, password: password, password_confirmation: password)
      if user.valid?
        super
      else
        @designer.update(resource_params.first)
        user.errors.each { |k, v| @designer.errors.add(k, v) }
        respond_with @designer, location: -> { resource_path }
      end
    end

    def destroy
      @designer = resource
      @designer.discard
      @designer.user.discard

      notice = [
        'Designer successfully deleted.',
        @designer.available_for_payout.nonzero? && "Pending earnings: #{@designer.available_for_payout}.",
        @designer.active_projects.present? && "Project IDs: #{@designer.active_projects.pluck(:id).join(', ')}."
      ].delete_if(&:blank?).join(' ')

      @designer.spots.active.destroy_all

      @designer.earnings.earned.each(&:deleted_designer!)

      redirect_to collection_url, notice: notice
    end
  end
end
