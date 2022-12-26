# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceMailer do
  describe '#bank_transfer_invoice_email' do
    let(:user) { create(:designer).user }
    let(:invoice_pdf_content) { WickedPdf.new.pdf_from_string('pdf') }
    let(:mail) { InvoiceMailer.bank_transfer_invoice_email(user, invoice_pdf_content).deliver }

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['chris@designbro.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match('Please complete the transfer now in order for your design project to kick off.')
    end
  end
end
