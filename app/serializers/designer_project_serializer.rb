# frozen_string_literal: true

class DesignerProjectSerializer < ProjectBaseSerializer
  attributes :nda_type,
             :nda_accepted,
             :nda

  belongs_to :brand, serializer: BrandAttributesSerializer

  def nda_type
    object.brand.active_nda&.nda_type
  end

  def nda_accepted
    user = view_context.current_api_v1_user

    user.designer.designer_ndas.exists?(nda: object.brand.active_nda) if user&.designer?
  end

  def nda
    object.brand.active_nda
  end
end
