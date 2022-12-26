# frozen_string_literal: true

module ProjectBuilderV2
  module Create
    class BaseForm < ::BaseForm
      attribute :product_key, String
      attribute :brand_id, Integer
      attribute :brand_name, String
      attribute :client, Object
      attribute :referrer, String

      validates :product_key, presence: true

      private

      def persist!
        raise(NotImplementedError)
      end

      def brand_dna
        brand.brand_dnas.first_or_create!
      end

      def brand
        @brand ||= if client
                     if new_brand?
                       client.company.brands.create!(name: brand_name)
                     else
                       client.company.brands.find(brand_id)
                     end
                   else
                     Brand.create!(name: brand_name)
                   end
      end

      def product
        @product ||= Product.find_by(key: product_key)
      end

      def new_brand?
        !brand_id
      end
    end
  end
end
