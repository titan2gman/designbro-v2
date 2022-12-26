# frozen_string_literal: true

class DiscountSerializer < ActiveModel::Serializer
  attributes :value,
             :code,
             :available,
             :discount_type,
             :max_num,
             :used_num,
             :end_date,
             :begin_date

  ['end_date', 'begin_date'].each do |method_name|
    define_method(method_name) do
      object.public_send(method_name).strftime('%m/%d/%Y')
    end
  end

  def available
    object.available?
  end
end
