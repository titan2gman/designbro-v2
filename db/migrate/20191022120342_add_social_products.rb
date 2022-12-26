class AddSocialProducts < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        category = ProductCategory.find_or_create_by!(
          name: 'Social',
          full_name: 'Social'
        )

        product = Product.find_or_create_by!(
          product_category: category,
          key: 'instagram-post',
          name: 'Instagram post',
          short_name: 'Instagram post',
          brand_name_hint: '',
          description: 'Get an original post for your instragram account, or get a professional designer to determine what your #instastyle should be!',

          what_is_it_for_label: 'What’s your Instagram post for?',
          what_is_it_for_hint: 'I need an Instagram post for next week’s live music event at our coffee bar',

          product_text_label: 'What text would you like to feature on your Instagram post?',

          tip_and_tricks_url: 'https://designbro.com/how-to-get-your-instagram-post'
        )

        product.update(price: 79)

        Product.find_by(key: 'logo').additional_design_prices.each do |price|
          product.additional_design_prices << price.dup
        end

        product = Product.find_or_create_by!(
          product_category: category,
          key: 'facebook',
          name: 'Facebook brand page design',
          short_name: 'Facebook brand page design',
          description: 'Our expert designers will create an original Facebook business page design for you.',
          brand_name_hint: '',
          tip_and_tricks_url: 'https://designbro.com/how-to-get-your-facebook-brand-page-design'
        )

        product.update(price: 79)

        Product.find_by(key: 'logo').additional_design_prices.each do |price|
          product.additional_design_prices << price.dup
        end

        product = Product.find_or_create_by!(
          product_category: category,
          key: 'twitter',
          name: 'Twitter profile',
          short_name: 'Twitter profile',
          description: "Get that 'professional look' on your twitter profile. Our experienced designers will design your Twitter profile page.",
          brand_name_hint: '',
          tip_and_tricks_url: 'https://designbro.com/how-to-get-your-twitter-profile'
        )

        product.update(price: 79)

        Product.find_by(key: 'logo').additional_design_prices.each do |price|
          product.additional_design_prices << price.dup
        end

        product = Product.find_or_create_by!(
          product_category: category,
          key: 'linkedin',
          name: 'LinkedIn company page design',
          short_name: 'LinkedIn company page design',
          description: 'Get a professional designer to create your LinkedIn business page. Get it done right & get noticed.',
          brand_name_hint: '',
          tip_and_tricks_url: 'https://designbro.com/how-to-get-your-linkedin-company-page-design'
        )

        product.update(price: 79)

        Product.find_by(key: 'logo').additional_design_prices.each do |price|
          product.additional_design_prices << price.dup
        end

        product = Product.find_or_create_by!(
          product_category: category,
          key: 'youtube',
          name: 'YouTube channel',
          short_name: 'YouTube channel',
          description: 'Get your YouTube channel designed by our professional designers. Make sure you get noticed.',
          brand_name_hint: '',
          tip_and_tricks_url: 'https://designbro.com/how-to-get-your-youtube-channel'
        )

        product.update(price: 79)

        Product.find_by(key: 'logo').additional_design_prices.each do |price|
          product.additional_design_prices << price.dup
        end
      end

      dir.down do
      end
    end
  end
end
