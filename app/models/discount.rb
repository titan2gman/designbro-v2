# frozen_string_literal: true

class Discount < ApplicationRecord
  enum discount_type: { percent: 0, dollar: 1 }

  has_many :projects

  scope :future, -> { where('begin_date > now()') }
  scope :active, -> { where('begin_date < now() and end_date > now()') }
  scope :finished, -> { where('end_date < now()') }

  ransacker :state, formatter: proc { |state|
    results = public_send(state).ids
    results.present? ? results : nil
  } do |parent|
    parent.table[:id]
  end

  validates :code, uniqueness: true
  validates :code, length: { minimum: 2 }
  validates :max_num, numericality: { greater_than_or_equal_to: :used_num }
  validates :code, :discount_type, :value, :begin_date, :end_date, :max_num, presence: true
  validates_date :begin_date, on_or_after: :now, on: :create
  validates_date :end_date, after: :begin_date

  def monetize(amount_to_discount)
    case discount_type
    when 'percent'
      amount_to_discount * value / 100
    when 'dollar'
      value
    end
  end

  def expired?
    end_date < Time.zone.now
  end

  def fully_used?
    used_num >= max_num
  end

  def future?
    begin_date > Time.zone.now
  end

  def unavailable?
    fully_used? || future? || expired?
  end

  def available?
    !unavailable?
  end
end
