# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DisapprovePortfolioJob do
  describe '#perform_later' do
    it 'creates job' do
      designer = create(:designer)

      expect { DisapprovePortfolioJob.perform_later(designer.id, designer.count_of_disapproved_states) }
        .to have_enqueued_job(DisapprovePortfolioJob).with(designer.id, designer.count_of_disapproved_states)

      expect(DisapprovePortfolioJob).to have_been_enqueued.exactly(:once)
    end
  end

  describe '#perform_now' do
    it 'sends mailer' do
      designer = create(:designer)

      expect(DesignerMailer).to receive(:portfolio_disapproved).with(user: designer.user).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_now) }
      )

      DisapprovePortfolioJob.perform_now(designer.id, designer.count_of_disapproved_states)
    end

    it 'not sends mailer' do
      designer = create(:designer)

      expect(DesignerMailer).not_to receive(:portfolio_disapproved)

      DisapprovePortfolioJob.perform_now(designer.id, designer.count_of_disapproved_states - 1)
    end
  end
end
