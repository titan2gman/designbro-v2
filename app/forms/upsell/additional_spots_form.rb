# frozen_string_literal: true

class Upsell::AdditionalSpotsForm < Upsell::BaseForm
  presents :project

  attribute :number_of_spots, Integer

  validates :number_of_spots, presence: true

  private

  def update_project!
    project.max_spots_count = project.max_spots_count + number_of_spots
    project.price = Money.from_amount(project.price) + total_price
    project.type_price = project.project_type_price
    project.save!
  end

  def total_price
    @total_price ||= surcharge_price_with_discount + vat_amount
  end

  def surcharge_price_with_discount
    @surcharge_price_with_discount ||= surcharge_price - discount_amount
  end

  def upsell_price
    @upsell_price ||= new_additional_price_amount - current_additional_price_amount
  end

  def surcharge_price
    @surcharge_price = upsell_price * (1 + ::ADDITIONAL_SPOTS_SURCHARGE)
  end

  def new_additional_price_amount
    project.product.additional_design_prices.find_by!(
      quantity: project.max_spots_count
    ).amount
  end

  def current_additional_price_amount
    project.product.additional_design_prices.find_by(
      quantity: project.max_spots_count - number_of_spots
    )&.amount || 0
  end

  def vat_amount
    @vat_amount ||= NewVatCalculator.new(client.company, surcharge_price_with_discount).call
  end

  def discount_amount
    @discount_amount ||= Money.from_amount(discount&.monetize(BigDecimal(surcharge_price.to_s)) || 0)
  end

  def upsell_type
    :additional_spots
  end
end
