class CreateWebsiteBannersProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :what_is_it_for, :text

    add_column :products, :what_is_it_for_label, :string
    add_column :products, :what_is_it_for_hint, :string

    reversible do |dir|
      dir.up do
        category = ProductCategory.find_by!(name: 'Online Media')

        product = Product.find_or_create_by!(
          product_category: category,
          key: 'website-banner',
          name: 'Website banner',
          short_name: 'website banner',
          description: 'Get your online banners designed. Includes a selection of the most common sizes for advertising on websites.',

          brand_name_hint: "Please write the name you'd like to be the main feature of your banners",

          what_is_it_for_label: 'What’s your banner for?',
          what_is_it_for_hint: 'For instance: I would like to create a banner that tells customers about the special deal they get when they register through our website.',

          product_text_label: 'What text would you like to feature on your banner?',
          product_text_hint: 'You can also copy and paste your text here, that way line breaks are preserved',

          tip_and_tricks_url: 'https://designbro.com/how-to-get-your-website-banners'
        )

        product.update(price: 199)

        Product.find_by(key: 'logo').additional_design_prices.each do |price|
          product.additional_design_prices << price.dup
        end
      end

      dir.down do
      end
    end
  end
end
