# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ImageHelper do
  include Admin::ImageHelper

  describe '#image' do
    let(:portfolio_image) { create(:portfolio_image) }

    it 'returns image_tag' do
      expect(image(portfolio_image.uploaded_file.file.thumb))
        .to match(%r{<img class=\"thumb-image\" src=\"\/uploads\/thumb_[0-9a-f-]+.png\" \/>})
    end

    it 'returns no image' do
      expect(image(nil)).to eq('<span>no image yet</span>')
    end
  end
end
