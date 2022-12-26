# frozen_string_literal: true

module Admin
  module NestedHelper
    def nested_links(object, association, title = :title)
      object.send(association).map do |nested_object|
        auto_link(nested_object, nested_object.send(title))
      end.join(', ').html_safe
    end
  end
end
