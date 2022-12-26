# frozen_string_literal: true

module Transactionable
  extend ActiveSupport::Concern

  def generate_transaction_id
    # if entity was persisted before (has ID) then
    # you will be able to retrieve transaction ID
    # otherwise you will get nil

    "#{Date.today.strftime('%d%m%y')}-#{id.to_s.rjust(5, '0')}" if id
  end
end
