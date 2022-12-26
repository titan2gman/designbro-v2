# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment do
  it_should_behave_like 'transactionable', :payment_id

  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to have_one(:client).through :project }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:project) }
    it { is_expected.to validate_presence_of(:payment_type) }
  end

  describe 'instance methods' do
    describe '#price' do
      it 'returns project price' do
        project = create(:project)
        expect(create(:payment).price).to eq project.price
      end
    end
  end
end
