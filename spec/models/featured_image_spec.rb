# frozen_string_literal: true

RSpec.describe FeaturedImage do
  describe 'associations' do
    it { is_expected.to belong_to(:project) }

    it { is_expected.to have_one(:uploaded_featured_image).class_name('UploadedFile::FeaturedImage').dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:uploaded_featured_image) }
  end
end
