# frozen_string_literal: true

class FinalistsQuery
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def call
    Designer
      .select('designers.*, brands.name as brand_name, products.name as product_name, spots.state as spot_state, max(projects.created_at) as project_created_at')
      .joins(spots: { project: [:product, { brand_dna: :brand }] })
      .where(spots: { state: [:winner, :finalist] }, brands: { company_id: client.company_id })
      .group('designers.id, brand_name, product_name, spot_state')
      .distinct
  end
end
