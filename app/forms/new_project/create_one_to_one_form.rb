# frozen_string_literal: true

module NewProject
  class CreateOneToOneForm < NewProject::CreateForm
    include Wisper::Publisher
    include ::Checkoutable

    presents :project

    attribute :designer_id, Integer

    validates :designer_id, :payment_type, :client, presence: true

    private

    def persist!
      ActiveRecord::Base.transaction do
        update_client!
        update_project!
        create_nda!
        create_spot!

        send :"perform_#{payment_type}_payment"
      end

      OneToOnePaymentReceivedJob.set(wait: 1.hour).perform_later(project.id)
    end

    def update_client!
      client.update!(preferred_payment_method: payment_type) if payment_type
    end

    def update_project!
      project.update!(
        discoverable: false,
        max_spots_count: 1,
        discount: discount,
        discount_amount: discount_amount,
        designer_discount_amount: discount_amount,

        price: total_price,
        type_price: project_price,

        product: product,
        project_type: project_type,
        current_step: current_step,
        brand_dna: brand_dna,
        referrer: referrer
      )
    end

    def create_nda!
      Nda.create!(brand: brand, nda_type: :free, price: 0, paid: true) unless brand.active_nda
    end

    def create_spot!
      project.spots.create!(
        designer_id: designer_id,
        state: 'reserved',
        reserved_state_started_at: DateTime.now
      )
    end

    def create_payment!(args = {})
      Payment.create!(
        args.merge(
          payment_type: payment_type,
          project: project,
          total_price_paid: total_price,
          vat_price_paid: vat_amount,
          discount_amount_saved: discount_amount
        )
      )
    end

    def total_price
      @total_price ||= price_with_discount + vat_amount
    end

    def price_with_discount
      @price_with_discount ||= project_price - discount_amount
    end

    def project_price
      @project_price ||= product.one_to_one_price
    end

    def vat_amount
      @vat_amount ||= NewVatCalculator.new(client.company, price_with_discount).call
    end

    def discount
      @discount ||= Discount.find_by(code: discount_code)
    end

    def discount_amount
      @discount_amount ||= Money.from_amount(discount&.monetize(BigDecimal(project_price.to_s)) || 0)
    end

    def project_type
      'one_to_one'
    end

    def current_step
      if brand.has_paid_project
        product.project_builder_steps.mandatory_for_existing_brand.mandatory_for_one_to_one_project.first
      else
        product.project_builder_steps.mandatory_for_one_to_one_project.first
      end
    end
  end
end
