# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DesignerForm do
  describe '#save' do
    context 'with users email taken' do
      it 'has email taken error' do
        user = create(:user)
        designer = create(:designer, display_name: 'name')
        form = DesignerForm.new(
          id: designer.id,
          email: user.email,
          display_name: 'newName'
        )

        form.save

        expect(designer.reload.display_name).to eq('name')
        expect(form.designer.errors.messages).to eq(
          email: [I18n.t('errors.messages.taken')]
        )
      end
    end

    context 'with designer display_name taken' do
      it 'has display_name taken error' do
        user = create(:user, email: 'old@gmail.com')
        designer = create(:designer, user: user, display_name: 'name')
        designer2 = create(:designer)
        form = DesignerForm.new(
          id: designer.id,
          email: 'new@gmail.com',
          display_name: designer2.display_name
        )

        form.save

        expect(designer.user.reload.email).to eq('old@gmail.com')
        expect(form.designer.errors.messages).to eq(
          display_name: [I18n.t('errors.messages.taken')]
        )
      end
    end

    it 'invalid country code' do
      user = create(:user)
      designer = create(:designer, user: user)

      form = DesignerForm.new(
        country_code: 'ABC',
        id: designer.id
      )

      form.save

      expect(form.designer.errors.messages).to eq(
        country_code: ['is invalid']
      )
    end
  end
end
