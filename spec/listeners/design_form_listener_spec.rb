# frozen_string_literal: true

RSpec.describe DesignFormListener do
  let(:design) { create(:design) }

  describe '#new_design_uploaded' do
    it 'sends an email to client about new design' do
      expect(ClientMailer).to receive(:new_design_uploaded).with(design: design).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.new_design_uploaded(design)
    end
  end
end
