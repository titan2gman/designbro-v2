class AddPaymentNewColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :payment_intent_id, :string
    add_column :payments, :charge_id, :string

    add_monetize :payments, :total_price_paid, currency: { present: false }
    add_monetize :payments, :nda_price_paid, currency: { present: false }
    add_monetize :payments, :vat_price_paid, currency: { present: false }
    add_monetize :payments, :discount_amount_saved, currency: { present: false }

    add_monetize :payments, :processing_fee
    add_monetize :payments, :processing_fee_vat
  end
end
