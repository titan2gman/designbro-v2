# frozen_string_literal: true

module TimeMethods
  extend ActiveSupport::Concern

  def time_from(timepoint)
    (Time.zone.now - timepoint).round
  end
end
