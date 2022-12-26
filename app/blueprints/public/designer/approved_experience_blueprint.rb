# frozen_string_literal: true

class Public::Designer::ApprovedExperienceBlueprint < Blueprinter::Base
  identifier :id

  field :product_category do |experience|
    experience.product_category.name
  end
end
