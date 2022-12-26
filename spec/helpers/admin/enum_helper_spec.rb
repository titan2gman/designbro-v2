# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::EnumHelper do
  include Admin::EnumHelper

  describe '#enum_to_filter_collection' do
    it 'of Project.project_types' do
      expect(enum_to_filter_collection(Project.project_types))
        .to match('LOGO' => 0, 'PACKAGING' => 2, 'BRAND IDENTITY' => 1)
    end

    it 'of Discount.discount_types' do
      expect(enum_to_filter_collection(Discount.discount_types))
        .to match('PERCENT' => 0, 'DOLLAR' => 1)
    end
  end

  describe '#enum_to_input_collection' do
    it 'of Project.project_types' do
      expected = {
        'LOGO' => 'logo',
        'PACKAGING' => 'packaging',
        'BRAND IDENTITY' => 'brand_identity'
      }

      expect(enum_to_input_collection(Project.project_types)).to match(expected)
    end

    it 'of Discount.discount_types' do
      expect(enum_to_input_collection(Discount.discount_types))
        .to match('PERCENT' => 'percent', 'DOLLAR' => 'dollar')
    end
  end

  describe '#str_array_to_filter_collection' do
    it 'of Project.project_types.keys' do
      expected = {
        'LOGO' => 'logo',
        'PACKAGING' => 'packaging',
        'BRAND IDENTITY' => 'brand_identity'
      }

      actual = str_array_to_filter_collection(
        Project.project_types.keys
      )

      expect(actual).to match(expected)
    end

    it 'of Discount.discount_types.keys' do
      expect(str_array_to_filter_collection(Discount.discount_types.keys))
        .to match('PERCENT' => 'percent', 'DOLLAR' => 'dollar')
    end
  end
end
