# frozen_string_literal: true

class Upsell::BaseForm < BaseForm
  include Checkoutable

  presents :project

  attribute :client, Object

  validates :client, presence: true

  private

  def persist!
    ActiveRecord::Base.transaction do
      update_client!
      update_project!

      send :"perform_#{payment_type}_payment"
    end
  end

  def create_payment!(args = {})
    Payment.create!(
      args.merge(
        payment_type: payment_type,
        paid_for: upsell_type,
        project: project,
        total_price_paid: total_price,
        vat_price_paid: vat_amount,
        discount_amount_saved: discount_amount
      )
    )
  end

  def update_client!
    client.update!(preferred_payment_method: payment_type) if payment_type
  end

  def discount
    @discount ||= Discount.find_by(code: discount_code)
  end
end
