# frozen_string_literal: true

class NewBrandExampleSerializer < ActiveModel::Serializer
    type :new_brand_examples

    attributes :id, :url

    def url
      object.example.file.url
    end
  end
