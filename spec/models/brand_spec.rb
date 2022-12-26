# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Brand do
  describe 'associations' do
    it { is_expected.to belong_to(:company).optional }

    it { is_expected.to have_one(:active_nda).class_name('Nda') }
    it { is_expected.to have_many(:brand_dnas).dependent(:destroy) }
    it { is_expected.to have_many(:ndas).dependent(:destroy) }
    it { is_expected.to have_many(:competitors).dependent(:destroy) }
    it { is_expected.to have_many(:inspirations).dependent(:destroy) }
    it { is_expected.to have_many(:existing_designs).dependent(:destroy) }

    it { is_expected.to have_many(:projects).through(:brand_dnas) }
    it { is_expected.to have_many(:clients).through(:company) }

    it { is_expected.to have_many(:projects_completed).through(:brand_dnas) }
    it { is_expected.to have_many(:projects_in_progress).through(:brand_dnas) }
    it { is_expected.to have_many(:project_source_files).through(:brand_dnas) }
    it { is_expected.to have_many(:unread_designs).through(:brand_dnas) }

    it { is_expected.to accept_nested_attributes_for(:competitors).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:inspirations).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:existing_designs).allow_destroy(true) }
  end
end
