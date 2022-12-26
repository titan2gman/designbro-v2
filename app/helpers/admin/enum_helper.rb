# frozen_string_literal: true

module Admin
  module EnumHelper
    def enum_to_filter_collection(enum)
      enum.transform_keys { |key| key.humanize.upcase }
    end

    def enum_to_input_collection(enum)
      str_array_to_filter_collection(enum.keys)
    end

    def str_array_to_filter_collection(array)
      array.each_with_object({}) do |key, hash|
        hash[key.humanize.upcase] = key
      end
    end
  end
end
