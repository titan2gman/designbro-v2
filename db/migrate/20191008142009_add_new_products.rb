class AddNewProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :products, :brand_background_story_hint, 'Your background story'
    change_column_default :products, :product_text_hint, 'You can also copy and paste your text here, that way line breaks are preserved.'

    add_column :projects, :product_size, :string

    add_column :products, :product_size_label, :string
    add_column :products, :product_size_hint, :string

    reversible do |dir|
      dir.up do
        category = ProductCategory.find_or_create_by!(
          name: 'Print Media',
          full_name: 'Print Media'
        )

        product = Product.find_or_create_by!(
          product_category: category,
          key: 'flyer',
          name: 'Flyer',
          short_name: 'flyer',
          description: 'Need to get noticed? Our designers will create the perfect flyer for your company.',

          brand_name_hint: '',

          what_is_it_for_label: 'What’s your flyer for?',
          what_is_it_for_hint: 'For instance: I need a flyer for next week’s live music event at our coffee bar',

          product_text_label: 'What text would you like to feature on your flyer?',

          product_size_label: 'What’s going to be the size of your flyer?',
          product_size_hint: 'For instance: 5 inches by 3 inches',

          tip_and_tricks_url: 'https://designbro.com/how-to-get-your-flyer'
        )

        product.update(price: 199)

        Product.find_by(key: 'logo').additional_design_prices.each do |price|
          product.additional_design_prices << price.dup
        end

        product = Product.find_or_create_by!(
          product_category: category,
          key: 'poster',
          name: 'Poster',
          short_name: 'poster',
          description: 'Get professional designers to create your awesome poster design.',
          brand_name_hint: '',

          what_is_it_for_label: 'What’s your poster for?',
          what_is_it_for_hint: 'For instance: I need a poster for next week’s live music event at our coffee bar',

          product_size_label: 'What’s going to be the size of your poster?',
          product_size_hint: 'For instance: 18 inches by 24 inches',

          product_text_label: 'What text would you like to feature on your poster?',

          tip_and_tricks_url: 'https://designbro.com/how-to-get-your-poster'
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
