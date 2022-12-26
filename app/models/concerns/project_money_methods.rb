# frozen_string_literal: true

module ProjectMoneyMethods
  extend ActiveSupport::Concern

  PRIZE_PERCENT = 0.75
  WINNER_PRIZE_PERCENT = 0.95
  FINALISTS_PRIZE_PERCENT = 0.05

  def price
    (normalized_price || 0) / 100.0
  end

  def price=(price)
    self.normalized_price = price.to_f * 100 if price
  end

  def type_price
    (normalized_type_price || 0) / 100.0
  end

  def type_price=(price)
    self.normalized_type_price = price * 100 if price
  end

  def total_prize
    ((type_price - designer_discount_amount.to_f) * PRIZE_PERCENT).to_i
  end

  def winner_prize
    (finalists.empty? ? total_prize : total_prize * WINNER_PRIZE_PERCENT).to_i
  end

  def finalist_prize
    return 0 if finalists.empty?

    (total_prize * FINALISTS_PRIZE_PERCENT / spots.finalist_states.count).to_i
  end

  [:winner_prize, :finalist_prize, :total_prize].each do |method|
    define_method("#{method}_in_cents") do
      send(method) * 100
    end
  end
end
