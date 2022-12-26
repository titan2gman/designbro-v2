# frozen_string_literal: true

RSpec.describe ProjectSourceFile do
  describe 'associations' do
    it { is_expected.to belong_to :project }
    it { is_expected.to belong_to :designer }

    it { is_expected.to have_one(:source_file).dependent(:destroy) }
  end
end
