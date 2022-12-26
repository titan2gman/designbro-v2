# frozen_string_literal: true

ActiveAdmin.register Design do
  actions :index, :show

  includes :spot,
           :uploaded_file,
           designer: { designer_client_blocks: :client },
           project: [
             :product, { brand_dna: :brand },
             company: :clients
           ]

  member_action :admin_destroy, method: :delete do
    resource.spot.mark_as_deleted_by_admin!
    redirect_to collection_url, notice: 'Deleted by Admin!'
  end

  csv do
    column :id
    column :name

    column :designer do |design|
      design.designer.display_name
    end

    column :clients do |design|
      design.project.company.clients.map(&:name)
    end

    column :project do |design|
      design.project.name
    end

    column :project_type
    column :product_key

    column :state

    column :blocked do |design|
      design.designer.designer_client_blocks.to_a.filter do |block|
        design.project.company.clients.map(&:id).include?(block.client_id)
      end.any?
    end

    column :rating

    column :created_at
    column :updated_at
  end

  index do
    selectable_column

    column :id
    column :name

    column :image do |design|
      image(design.uploaded_file.file, :small)
    end

    column :designer
    column :project

    tag_column :project_type
    tag_column :product_key

    column :clients do |design|
      design.project.company.clients.map do |client|
        link_to client.name, [ActiveAdmin.application.default_namespace, client]
      end
    end

    tag_column :state

    bool_column :blocked do |design|
      design.designer.designer_client_blocks.to_a.filter do |block|
        design.project.company.clients.map(&:id).include?(block.client_id)
      end.any?
    end

    column :rating

    actions defaults: true do |design|
      if design.spot.design_uploaded?
        item 'Delete',
             [:admin_destroy, ActiveAdmin.application.default_namespace, design],
             class: 'member_link',
             method: :delete,
             confirm: "Do you want to mark it as 'deleted by admin'?"
      end
    end
  end

  filter :product, input_html: { class: 'select2' }

  filter :project, collection: lambda {
    Project.preload(:product, brand_dna: :brand).where.not(state: 'draft')
  }, input_html: { class: 'select2' }

  filter :spot_designer_user_email_cont, label: 'Designer email', as: :string

  filter :spot_project_brand_dna_brand_company_clients_user_email_cont, label: 'Client email', as: :string

  filter :by_spot_state, label: 'STATE', as: :select, collection: lambda {
    str_array_to_filter_collection(Spot::CAN_HAVE_DESIGN_STATES)
  }

  filter :by_blocked_flag, label: 'BLOCKED', as: :select, collection: lambda {
    str_array_to_filter_collection(['blocked', 'non_blocked'])
  }

  filter :rating

  show do
    attributes_table do
      row :id
      row :name

      row :image do |d|
        image(d.uploaded_file.file)
      end

      row :designer
      row :project

      tag_row :project_type
      tag_row :product_key

      row :clients do |d|
        d.project.company.clients.map do |client|
          link_to client.email, [ActiveAdmin.application.default_namespace, client]
        end
      end

      tag_row :state

      bool_row :blocked do |d|
        DesignerClientBlock.exists?(
          designer: d.designer,
          client: d.project.company.clients
        )
      end

      row :rating
      row :created_at
      row :updated_at
    end

    panel 'Versions' do
      table_for design.design_versions do
        column :name

        column :image do |version|
          image(version.uploaded_file.file, :small)
        end

        column :created_at
        column :updated_at
      end
    end
  end

  action_item :delete, only: :show do
    if design.spot.design_uploaded?
      link_to 'Delete',
              [:admin_destroy, ActiveAdmin.application.default_namespace, design],
              class: 'member_link',
              method: :delete,
              confirm: "Do you want to mark it as 'deleted by admin'?"
    end
  end
end
