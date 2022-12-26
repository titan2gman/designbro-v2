# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_one :client }
    it { is_expected.to have_one :designer }
  end

  describe '#state' do
    context 'initial (pending)' do
      it { is_expected.to have_state(:pending) }
    end

    context 'active' do
      it { is_expected.to allow_event(:approve) }
      it { is_expected.to transition_from(:pending).to(:active).on_event(:approve) }
    end

    context 'active' do
      it { is_expected.to allow_event(:approve) }
      it { is_expected.to transition_from(:pending).to(:active).on_event(:approve) }
      it { is_expected.to transition_from(:disabled).to(:active).on_event(:approve) }
    end

    context 'disabled' do
      it { is_expected.to allow_event(:disable) }
      it { is_expected.to transition_from(:pending).to(:disabled).on_event(:disable) }
      it { is_expected.to transition_from(:active).to(:disabled).on_event(:disable) }
    end
  end

  describe '#object' do
    it 'returns designer' do
      user = build(:user)
      designer = double('designer')
      allow(user).to receive(:designer).and_return(designer)

      result = user.object

      expect(result).to eq(designer)
    end
  end

  describe '#token_validation_response' do
    it 'serilizes object (designer)' do
      designer = build(:designer)
      user = build(:user, designer: designer)

      result = user.token_validation_response

      expect(result.class).to eq(Hash)
      expect(result[:type]).to eq('designers')
    end
  end

  describe '#designer' do
    it 'is true when linked object is designer' do
      user = build(:user, designer: build(:designer))

      result = user.designer?

      expect(result).to eq(true)
    end
  end

  describe '#client' do
    it 'is true when linked object is client' do
      user = build(:user, client: build(:client))

      result = user.client?

      expect(result).to eq(true)
    end
  end

  describe '#after_confirmation' do
    it 'mark client as active' do
      user = create(:client).user
      user.send :after_confirmation

      expect(user.state).to eq('active')
    end

    it 'does not mark designer as active' do
      user = create(:designer).user
      user.send :after_confirmation

      expect(user.state).to eq('pending')
    end
  end
end
