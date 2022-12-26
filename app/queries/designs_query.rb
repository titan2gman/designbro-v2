# frozen_string_literal: true

module DesignsQuery
  class Blocked
    include Callable

    def call
      Design
        .joins(project: { brand_dna: { brand: { company: :clients } } }, designer: :designer_client_blocks)
        .where('designer_client_blocks.client_id = clients.id')
    end
  end

  class NonBlocked
    include Callable

    def call
      Design
        .left_joins(project: { brand_dna: { brand: { company: :clients } } }, designer: :designer_client_blocks)
        .where('
          designer_client_blocks.client_id IS NULL OR
          designer_client_blocks.client_id <> clients.id
        ')
    end
  end
end
