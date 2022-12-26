class CreatePaymentMethodType < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE payment_method AS ENUM (
        'credit_card',
        'paypal',
        'bank_transfer'
      );
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE payment_method;
    SQL
  end
end
