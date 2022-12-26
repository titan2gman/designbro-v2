# frozen_string_literal: true

class PayoutMailer < ApplicationMailer
  default to: ENV.fetch('PAYOUT_EMAIL')

  def payout_request(payout:)
    @payout = payout

    mail(subject: default_i18n_subject(amount: @payout.amount / 100, designer_displayname: @payout.designer.display_name))
  end
end
