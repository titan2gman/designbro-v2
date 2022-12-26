# frozen_string_literal: true

class InvoiceMailer < ApplicationMailer
  def bank_transfer_invoice_email(user, url)
    @url = url

    mail(to: user.email)
  end
end
