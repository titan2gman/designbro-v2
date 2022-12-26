# frozen_string_literal: true

RSpec.describe Competitor do
  describe 'associations' do
    it { is_expected.to belong_to(:brand) }

    it { is_expected.to have_one(:competitor_logo).class_name('UploadedFile::CompetitorLogo').dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:competitor_logo) }
  end
end
