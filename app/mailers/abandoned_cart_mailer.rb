# frozen_string_literal: true

class AbandonedCartMailer < ApplicationMailer
  layout 'abandoned_cart_mailer'

  def send_abandoned_cart_email(project:, client:, reminder_step:)
    @project = project
    @reminder_step = reminder_step
    provider = AbandonedCarts::EmailDataProvider.new(@project, client, reminder_step)
    @voucher_code = provider.voucher_code unless project.third_reminder?
    @continue_brief_url = provider.continue_brief_url
    @unsubscribe_url = provider.unsubscribe_url
    @tip_and_tricks_url = provider.tip_and_tricks_url

    @project_price = provider.project_price
    @discount_amount = provider.discount_amount_title
    @discount_price = provider.discount_price
    @total_price = provider.total_price

    mail(to: client.email, subject: provider.email_subject, template_path: template_set_name)
  end

  alias abandoned_cart_first_reminder send_abandoned_cart_email
  alias abandoned_cart_second_reminder send_abandoned_cart_email
  alias abandoned_cart_third_reminder send_abandoned_cart_email

  def template_set_name
    "abandoned_cart_mailer/set_#{@project.email_template_set_name}"
  end
end
