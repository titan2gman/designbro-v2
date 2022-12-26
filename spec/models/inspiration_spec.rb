# frozen_string_literal: true

RSpec.describe Inspiration do
  describe 'associations' do
    it { is_expected.to belong_to(:brand) }

    it { is_expected.to have_one(:inspiration_image).class_name('UploadedFile::InspirationImage').dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :inspiration_image }
  end
end
