# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationRecord do
  it 'is abstract' do
    result = ApplicationRecord.abstract_class

    expect(result).to eq(true)
  end
end
