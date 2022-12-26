# frozen_string_literal: true

module Serializable
  extend ActiveSupport::Concern

  def read_attribute_for_serialization(attribute)
    public_send(attribute)
  end
end
