# frozen_string_literal: true

data = HashWithIndifferentAccess.new(YAML.load_file(File.join(Rails.root, 'db', 'products.yml')))

namespace :products do
  task load: :environment do
    data[:product_categories]&.each do |product_category|
      pc = ProductCategory.find_or_create_by!(
        name: product_category[:name],
        full_name: product_category[:full_name]
      )

      product_category[:products]&.each do |product|
        product_record = pc.products.find_or_initialize_by(key: product[:key])

        product_record.update!(product.except(:project_builder_steps))

        product[:project_builder_steps]&.each do |project_builder_step|
          step_record = product_record.project_builder_steps.find_or_initialize_by(
            path: project_builder_step[:path]
          )

          step_record.update!(
            name: project_builder_step[:name],
            description: project_builder_step[:description],
            form_name: project_builder_step[:form_name],
            mandatory_for_one_to_one_project: project_builder_step[:mandatory_for_one_to_one_project] || false,
            mandatory_for_existing_brand: project_builder_step[:mandatory_for_existing_brand] || false,
            authentication_required: project_builder_step[:authentication_required],
            component_name: project_builder_step[:component_name]
          )

          project_builder_step[:project_builder_questions]&.each do |question|
            question_record = step_record.project_builder_questions.find_or_initialize_by(
              attribute_name: question[:attribute_name],
              component_name: question[:component_name]
            )

            question_record.update!(
              props: question[:props],
              validations: question[:validations],
              mandatory: question[:mandatory] || false
            )
          end
        end
      end
    end
  end

  task tshirt: :environment do
    product = Product.find_by(key: 't-shirt')

    [55, 110, 165, 220, 275, 330, 385].each_with_index do |price, index|
      AdditionalDesignPrice.create!(
        quantity: index + 4,
        amount: price,
        product: product
      )
    end
  end

  task zoom_update: :environment do
    product = Product.find_by(key: 'zoom-background')

    Project.where(product: product).where.not(current_step: nil).update(current_step: nil)

    product.project_builder_steps.destroy_all
  end

  task zoom_update_after: :environment do
    product = Product.find_by(key: 'zoom-background')

    Project.where(product: product, state: 'draft').update(current_step: product.project_builder_steps.first)
  end

  task menu: :environment do
    product = Product.find_by(key: 'menu')

    Product.find_by(key: 'logo').additional_design_prices.each do |price|
      product.additional_design_prices << price.dup
    end
  end
end
