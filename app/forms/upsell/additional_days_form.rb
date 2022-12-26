# frozen_string_literal: true

class Upsell::AdditionalDaysForm < Upsell::BaseForm
  presents :project

  attribute :number_of_days, Integer

  validates :number_of_days, presence: true

  private

  def update_project!
    project.additional_days = project.additional_days + number_of_days
    project.price = Money.from_amount(project.price) + total_price
    project.type_price = project.project_type_price
    project["#{project.state}_expires_at"] = project["#{project.state}_expires_at"] + number_of_days.days
    project.save!
  end

  def total_price
    @total_price ||= price_with_discount + vat_amount
  end

  def price_with_discount
    @price_with_discount ||= upsell_price - discount_amount
  end

  def upsell_price
    @upsell_price ||= number_of_days * Money.from_amount(ADDITIONAL_TIME_PRICE_PER_DAY)
  end

  def vat_amount
    @vat_amount ||= NewVatCalculator.new(client.company, price_with_discount).call
  end

  def discount_amount
    @discount_amount ||= Money.from_amount(discount&.monetize(BigDecimal(upsell_price.to_s)) || 0)
  end

  def upsell_type
    :additional_time
  end
end
