# frozen_string_literal: true

ActiveAdmin.register Project, as: 'Winner' do
  actions :index, :show

  includes :product, { brand_dna: { brand: :active_nda } }, { spots: :design }, company: { clients: :user }

  controller do
    def scoped_collection
      super.completed
    end
  end

  index do
    column :id

    column :image do |project|
      image(project.featured_image&.uploaded_featured_image&.file, :small)
    end

    column :nda do |project|
      ['standard', 'custom'].include?(project.active_nda.nda_type) ? status_tag('yes') : status_tag('no')
    end

    column :brand do |project|
      project.brand.name
    end

    column :product do |project|
      project.product.name
    end

    column :company do |project|
      project.company.name
    end

    column :clients do |project|
      project.clients.map(&:display_name).join(', ')
    end

    column :files do |project|
      link_to 'View', "/c/projects/#{project.id}/files"
    end
  end

  filter :by_active_nda, label: 'NDA', as: :select, collection: ['yes', 'no']
end
