# frozen_string_literal: true

class EmailsController < Api::V1::ApplicationController
  def unsubscribe_abandoned_cart
    redirect_to service.call
  end

  private

  def service
    @service ||= Emails::AbandonedCarts::Unsubscribe.new(params[:token])
  end
end
