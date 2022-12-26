# frozen_string_literal: true

class BrandAttributesSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :slogan,
             :additional_text,
             :description,
             :background_story,
             :where_it_is_used,
             :what_is_special,
             :logo,
             :projects_in_progress_count,
             :projects_completed_count,
             :files_count,
             :unread_count,
             :has_nda,
             :has_logo_project,
             :has_paid_project

  def projects_in_progress_count
    object.projects_in_progress.length
  end

  def projects_completed_count
    object.projects_completed.length
  end

  def files_count
    object.project_source_files.length
  end

  def has_nda
    object.active_nda_not_free?
  end

  def unread_count
    object.unread_designs.length
  end

  def logo
    logo_projects = object.projects.includes(:featured_image).where(
      product: Product.find_by(key: 'logo'), state: :completed
    ).where.not(featured_images: { id: nil })

    return logo_projects.first.featured_image.uploaded_featured_image.file.url if logo_projects.any?
  end

  def has_logo_project
    object.projects.where(product: Product.find_by(key: 'logo')).any?
  end
end
