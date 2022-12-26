# frozen_string_literal: true

class ReceiptsController < Api::V1::ApplicationController
  before_action :authenticate_client!
  load_and_authorize_resource :payment

  def show
    @project = @payment.project

    raise ActiveRecord::RecordNotFound if Project::NOT_ALLOWED_FOR_RECEIPT_GENERATION_STATES.include? @project.state

    @nda = @project.brand.ndas&.first
    @company = @project.company
    @vat_price = @payment.vat_price_paid

    respond_to do |format|
      format.html { render layout: false }
      format.pdf  { render pdf: "#{Time.now.to_i}_receipt.pdf", layout: false }
    end
  end
end
