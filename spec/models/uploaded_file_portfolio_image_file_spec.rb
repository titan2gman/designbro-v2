# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UploadedFile::PortfolioImageFile, type: :model do
  describe 'validations' do
    let(:portfolio_image) { create(:portfolio_image) }
    subject(:uploaded_file) { portfolio_image.uploaded_file }

    before { uploaded_file.update(entity: portfolio_image) }

    it { expect { subject.destroy }.to raise_error('Cannot delete while entity exists') }
  end
end
