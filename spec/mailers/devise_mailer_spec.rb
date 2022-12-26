# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseMailer do
  describe '#password_changed' do
    let(:user) { create(:designer).user }
    let(:mail) { DeviseMailer.password_changed(user).deliver }

    it 'renders the subject' do
      expect(mail.subject).to eq('Password Changed')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['chris@designbro.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match('We successfully changed your password.')
    end
  end
end
