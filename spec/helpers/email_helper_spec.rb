# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailsHelper do
  include EmailsHelper

  describe '#letterify_name' do
    let(:name) { 'First Last' }

    it 'returns letterify name' do
      expect(letterify_name(name)).to eq('FL')
    end
  end

  describe '#user_link' do
    subject { user_link(user) }

    describe 'client' do
      let(:user) { create(:client).user }
      it { is_expected.to eq('c') }
    end

    describe 'designer' do
      let(:user) { create(:designer).user }
      it { is_expected.to eq('d') }
    end
  end

  describe '#user_role' do
    subject { user_role(user) }

    describe 'client' do
      let(:user) { create(:client).user }
      it { is_expected.to eq('CLIENT') }
    end

    describe 'designer' do
      let(:user) { create(:designer).user }
      it { is_expected.to eq('DESIGNER') }
    end
  end

  describe '#project_type_name' do
    PROJECT_TYPE_NAMES = {
      logo: 'Logo',
      packaging: 'Packaging',
      brand_identity: 'Brand identity'
    }.freeze

    subject { project_type_name(project) }

    PROJECT_TYPE_NAMES.each do |project_type, project_type_name|
      describe project_type.to_s do
        let(:project) { create(:"#{project_type}_project") }

        it { is_expected.to eq(project_type_name) }
      end
    end
  end

  describe '#cut_on_word' do
    it 'returns 1234... for 1234 1234 with length 4' do
      expect(cut_on_word('1234 1234', 4)).to eq('1234...')
    end

    it 'returns 1234 for 1234 without length' do
      expect(cut_on_word('1234')).to eq('1234')
    end
  end
end
