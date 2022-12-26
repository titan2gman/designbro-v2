# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class CheckoutStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :vat, String
      attribute :country_code, String
      attribute :discount_code, String

      attribute :company_name, String

      attribute :last_name, String
      attribute :first_name, String

      attribute :client, Object
      attribute :ip, String

      private

      def persist!
        persist_company!
        persist_client!
        persist_company_city!
        persist_project_properties!
        persist_project_discount! if discount_available
        save_stripe_session! if upgrade_project_state
      end

      def persist_client!
        client.update!(
          first_name: first_name,
          last_name: last_name
        )
      end

      def persist_company!
        project.company.update!(
          country_code: country_code,
          company_name: company_name,
          vat: !company_name.present? && validate_form? ? nil : vat
        )
      end

      def persist_company_city!
        return if project.company.city

        project.company.update!(
          city: retrieve_city
        )
      end

      def persist_project_properties!
        # project.upgrade_to_brand_identity! if project.upgrade_package

        project.price = calculate_project_price
        project.type_price = project_type_price
        project.save!
      end

      def persist_project_discount!
        project.discount = discount
        project.discount_amount = discount.monetize(project.project_type_price + BigDecimal(project.nda_price.to_s))
        project.designer_discount_amount = discount.monetize(project.project_type_price)

        project.save
      end

      def save_stripe_session!
        session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          customer: retrieve_or_create_stripe_customer,
          line_items: [{
            price_data: {
              currency: 'usd',
              product: project.product.stripe_product_id,
              unit_amount: project.normalized_price
            },
            quantity: 1
          }],
          mode: 'payment',

          success_url: "#{ENV.fetch('ROOT_URL')}/new_project_success/#{project.id}?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: "#{ENV.fetch('ROOT_URL')}/new-project/#{project.id}/checkout"
        )

        project.update!(
          stripe_session_id: session.id
        )
      end

      def country
        ISO3166::Country.new(country_code)
      end

      def retrieve_city
        Geocoder.search(ip).first&.city
      end

      def nda_standard?
        nda_type == 'standard'
      end

      def nda_free?
        nda_type == 'free'
      end

      def calculate_project_price
        project_type_price + vat_price + nda_price - discount_amount
      end

      def vat_price
        BigDecimal(project.company ? VatCalculator.new(project).call.to_s : 0)
      end

      def nda_price
        BigDecimal(project.nda_price.to_s)
      end

      def discount_amount
        BigDecimal(project.discount_amount.to_s)
      end

      def project_type_price
        BigDecimal(project.project_type_price.to_s)
      end

      def discount
        @discount ||= Discount.active.find_by(code: discount_code)
      end

      def discount_available
        discount && !(discount.unavailable? && discount != project.discount)
      end

      def retrieve_or_create_stripe_customer
        if client.stripe_customer
          customer = Stripe::Customer.retrieve(client.stripe_customer)
        else
          customer = Stripe::Customer.create(
            email: client.email
          )

          client.update!(
            stripe_customer: customer.id
          )
        end

        customer
      end
    end
  end
end
