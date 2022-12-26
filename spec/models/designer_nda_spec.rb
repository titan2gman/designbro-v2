# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DesignerNda, type: :model do
  describe 'indexes' do
    it { is_expected.to have_db_index(:nda_id) }
    it { is_expected.to have_db_index(:designer_id) }

    it { is_expected.to have_db_index([:designer_id, :nda_id]).unique }
  end

  describe 'columns' do
    it { is_expected.to have_db_column(:designer_id).of_type(:integer).with_options(null: false, index: true) }
    it { is_expected.to have_db_column(:nda_id).of_type(:integer).with_options(null: false, index: true) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:nda) }
    it { is_expected.to belong_to(:designer) }

    it { is_expected.to have_one(:project).through(:nda) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:nda) }
    it { is_expected.to validate_presence_of(:designer) }

    it 'should validate uniqueness of Designer scoped to Project' do
      # https://github.com/thoughtbot/shoulda-matchers/issues/682

      subject.nda = create(:nda)
      subject.designer = create(:designer)

      is_expected.to validate_uniqueness_of(:designer_id).scoped_to(:nda_id)
    end
  end
end
