class AddManualProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :block_designer_available, :boolean, null: false, default: true
    add_column :projects, :eliminate_designer_available, :boolean, null: false, default: true
    add_reference :projects, :manual_product_category, foreign_key: { to_table: :product_categories }

    category = ProductCategory.find_or_create_by!(
      name: 'Other',
      full_name: 'Other'
    )

    product = Product.find_or_create_by!(
      product_category: category,
      key: 'manual',
      name: 'Manual',
      short_name: 'Manual post',
      tip_and_tricks_url: 'https://designbro.com',
      active: false
    )

    product.update(price: 199)

    Product.find_by(key: 'logo').additional_design_prices.each do |price|
      product.additional_design_prices << price.dup
    end
  end
end
