# frozen_string_literal: true

RSpec.describe SpotListener do
  let(:design) { create(:design) }

  describe '#design_eliminated' do
    it 'sends an email to designer when spot and design is eliminated' do
      expect(DesignerMailer).to receive(:design_eliminated).with(design: design).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.design_eliminated(design)
    end
  end
end
