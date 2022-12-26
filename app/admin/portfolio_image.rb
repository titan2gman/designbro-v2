# frozen_string_literal: true

ActiveAdmin.register PortfolioImage do
  menu parent: 'Static'

  permit_params portfolio_list_ids: [],
                uploaded_file_attributes: [:id, :file, :file_cache]

  form do |f|
    semantic_errors

    f.inputs 'Image', for: [:uploaded_file, object.uploaded_file || UploadedFile::PortfolioImageFile.new] do |file|
      file.input :file, as: :file, hint: image(object.uploaded_file&.file&.thumb)
      file.input :file_cache, as: :hidden
    end

    f.inputs do
      f.input :portfolio_lists, as: :check_boxes, collection: PortfolioList.all
    end

    actions
  end

  show do
    attributes_table do
      row :image do |portfolio_image|
        image(portfolio_image.uploaded_file.file.thumb)
      end
      row :portfolio_lists do |portfolio_image|
        nested_links(portfolio_image, :portfolio_lists, :list_type)
      end
    end
  end

  index do
    selectable_column
    id_column
    column :image do |portfolio_image|
      image(portfolio_image.uploaded_file.file.small, :small)
    end
    column :portfolio_lists do |portfolio_image|
      nested_links(portfolio_image, :portfolio_lists, :list_type)
    end
    actions
  end

  filter :portfolio_lists

  controller do
    def create
      super
      resource.uploaded_file.update(entity: resource)
    end
  end
end
