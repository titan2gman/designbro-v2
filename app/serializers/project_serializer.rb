# frozen_string_literal: true

class ProjectSerializer < ProjectBaseSerializer
  attributes :client_name,
             :nda_accepted,
             :stock_images_exist

  belongs_to :current_step
  belongs_to :brand
  belongs_to :creator

  def client_name
    object.creator&.display_name
  end

  def nda_accepted
    user = view_context.current_api_v1_user

    user.designer.designer_ndas.joins(brand: { brand_dnas: :projects }).exists?(projects: { id: object.id }) if user&.designer?
  end
end
