# frozen_string_literal: true

RSpec.describe ExistingDesign do
  describe 'associations' do
    it { is_expected.to belong_to(:brand) }

    it { is_expected.to have_one(:existing_logo).class_name('UploadedFile::ExistingLogo').dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :existing_logo }
  end
end
