# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientForm do
  describe '#save' do
    context 'with users email taken' do
      it 'has email taken error' do
        user = create(:user)
        client = create(:client)
        form = ClientForm.new(
          id: client.id,
          email: user.email
        )

        form.save

        expect(form.client.errors.messages).to eq(
          email: [I18n.t('errors.messages.taken')]
        )
      end
    end

    context 'validations', type: :model do
      it 'should be invalid if country is unreal' do
        form = ClientForm.new(country: 'AA', country_code: 'A', upgrade_project_state: true)
        expect(form).to be_invalid

        errors = form.errors.messages[:country_code]
        expect(errors).to include('is invalid')
      end

      it 'should be valid if country code is real' do
        form = ClientForm.new(country: 'Ukraine', country_code: 'UA', upgrade_project_state: true)
        expect(form.errors.messages[:country_code]).to be_empty
      end
    end
  end
end
