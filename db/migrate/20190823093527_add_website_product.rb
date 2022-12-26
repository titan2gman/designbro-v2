class AddWebsiteProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :product_text, :text

    add_column :products, :short_name, :string

    add_column :products, :brand_name_hint, :string

    add_column :products, :brand_additional_text_hint, :string

    add_column :products, :brand_background_story_hint, :string

    add_column :products, :product_text_label, :string
    add_column :products, :product_text_hint, :string

    add_column :designers, :portfolio_link, :string

    reversible do |dir|
      dir.up do
        category = ProductCategory.find_or_create_by!(name: 'Digital')

        product = Product.find_or_create_by!(
          name: 'Website',
          key: 'website',
          product_category: category
        )

        product.update(
          short_name: 'website',
          description: 'Includes a ‘non functional’ design for 3 pages, including your homepage.',
          brand_name_hint: "Please write the name you'd like to be the main feature of your logo",
          brand_background_story_hint: 'Your background story',
          product_text_label: 'What text would you like to feature on your website?',
          product_text_hint: 'If you don’t have any final text yet, don’t worry, just ask the designer to use sample text!',
          price: 345
        )

        Product.find_by(key: 'brand-identity').additional_design_prices.each do |price|
          product.additional_design_prices << price.dup
        end

        Product.find_by(key: 'logo').update(
          short_name: 'logo',
          brand_name_hint: "Please write the name you'd like to be the main feature of your logo",
          brand_additional_text_hint: "Any additional text you would like on the logo? For instance 'founded in 2016', or anything else that you want in your logo"
        )
        Product.find_by(key: 'brand-identity').update(
          short_name: 'brand identity',
          brand_name_hint: "Please write the name you'd like to be the main feature of your logo",
          brand_additional_text_hint: "Any additional text you would like on the logo? For instance 'founded in 2016', or anything else that you want in your logo"
        )
        Product.find_by(key: 'packaging').update(
          short_name: 'packaging',
          brand_name_hint: 'What is the name of your brand',
          brand_background_story_hint: "I.e. where does the product come from, how did you start, etc, all details can help!",
          brand_additional_text_hint: "For instance 'the best drink in the world' or 'founded in 2016' or 'made with passion'"
        )
      end

      dir.down do
      end
    end
  end
end
