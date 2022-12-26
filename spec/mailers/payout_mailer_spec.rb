# frozen_string_literal: true

RSpec.describe PayoutMailer do
  let(:designer) { create(:designer, display_name: 'SomeName') }
  let(:payout) { create(:payout, designer: designer, amount: 25_000) }

  describe '#payout_request' do
    let(:mail) { described_class.payout_request(payout: payout).deliver }

    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.to).to match_array(['staging-payout@yopmail.com']) }

    it { expect(mail.body.encoded).to match('This is payout request number:') }
    it do
      subject = I18n.t('payout_mailer.payout_request.subject', amount: 250, designer_displayname: 'SomeName')
      expect(mail.subject).to eq(subject)
    end
  end
end
