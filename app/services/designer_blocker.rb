# frozen_string_literal: true

class DesignerBlocker
  include Virtus.model

  SPOT_STATES = [
    Spot::STATE_IN_QUEUE,
    Spot::STATE_RESERVED,
    Spot::STATE_DESIGN_UPLOADED,
    Spot::STATE_STATIONERY,
    Spot::STATE_STATIONERY_UPLOADED,
    Spot::STATE_FINALIST
  ].freeze

  attribute :design, Design
  attribute :client, Client

  def call(block_design_params)
    @designer = design.designer

    ActiveRecord::Base.transaction do
      create_designer_client_block(block_design_params)
      eliminate_designer_spots

      @design
    end
  end

  private

  def create_designer_client_block(block_design_params)
    DesignerClientBlock.create!(
      designer: @designer,
      client: client,
      block_reason: block_design_params[:block_reason],
      block_custom_reason: block_design_params[:block_custom_reason]
    )
    DesignerMailer.designer_blocked(
      design: @design,
      reason: block_design_params[:block_reason]
    ).deliver_later
  end

  def eliminate_designer_spots
    @designer.spots.joins(
      project: { brand_dna: { brand: :company } }
    ).where(
      state: SPOT_STATES,
      projects: { brand_dnas: { brands: { company: client.company } } }
    ).each do |spot|
      spot.block!
      QueueSpotReserver.new(project: spot.project).call
    end
  end
end
