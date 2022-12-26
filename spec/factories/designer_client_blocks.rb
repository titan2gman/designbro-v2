# frozen_string_literal: true

FactoryBot.define do
  factory :designer_client_block do
    block_reason { DesignerClientBlock.block_reasons.keys.sample }

    designer
    client
  end
end
