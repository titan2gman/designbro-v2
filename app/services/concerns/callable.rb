# frozen_string_literal: true

module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(*args, &block)
      new(*args, &block).call
    end
  end
end
