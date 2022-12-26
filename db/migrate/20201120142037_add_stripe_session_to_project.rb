class AddStripeSessionToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :stripe_session_id, :string
    add_column :products, :stripe_product_id, :string

    reversible do |dir|
      dir.up do
        Product.find_by(key: 'logo2').update(stripe_product_id: 'prod_I5SScMwPn3Cf1O')
      end

      dir.down do
      end
    end
  end
end
