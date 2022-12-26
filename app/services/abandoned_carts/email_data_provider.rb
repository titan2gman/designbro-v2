# frozen_string_literal: true

module AbandonedCarts
  class EmailDataProvider
    def initialize(project, client, reminder_step)
      @project = project
      @client = client
      @reminder_step = reminder_step
    end

    def email_subject
      case reminder_step
      when 'first_reminder'
        "You’re almost there! Get #{discount_amount_title} off Today for your #{brand_name} design"
      when 'second_reminder'
        "Last Chance! Get #{discount_amount_title} off the next hour for your #{brand_name} design"
      when 'third_reminder'
        "Your design project for #{brand_name} is waiting to get started..."
      end
    end

    def continue_brief_url
      Deeplinks::ProjectBrief::Generate.new(client, project).call
    end

    def unsubscribe_url
      Emails::AbandonedCarts::GenerateUnsubscribeUrl.new(project).call
    end

    def tip_and_tricks_url
      project.product.tip_and_tricks_url
    end

    def voucher_code
      discount&.code
    end

    def discount_amount_title
      case discount&.discount_type
      when 'percent' then "#{discount.value}%"
      when 'dollar' then "#{discount.value}$"
      end
    end

    def project_price
      project.project_type_price + project.nda_price.to_f
    end

    def discount_price
      discount.monetize(project_price)
    end

    def total_price
      project_price - discount_price
    end

    private

    attr_reader :project, :client, :reminder_step

    def discount
      @discount ||= AbandonedCartDiscount.first&.discount
    end

    def brand_name
      project.brand_name
    end
  end
end
