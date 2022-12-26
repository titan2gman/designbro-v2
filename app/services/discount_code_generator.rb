# frozen_string_literal: true

class DiscountCodeGenerator
  def initialize(chars_count = 9, chars_array = [*('0'..'9'), *('A'..'Z')])
    @chars_count = chars_count
    @chars_array = chars_array
  end

  def call
    (1..@chars_count).map { @chars_array.sample }.join
  end
end
