# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApprovePortfolioJob do
  describe '#perform_later' do
    it 'creates job' do
      designer = create(:designer)

      expect { ApprovePortfolioJob.perform_later(designer.id, designer.count_of_approved_states) }
        .to have_enqueued_job(ApprovePortfolioJob).with(designer.id, designer.count_of_approved_states)

      expect(ApprovePortfolioJob).to have_been_enqueued.exactly(:once)
    end
  end

  describe '#perform_now' do
    it 'sends mailer' do
      designer = create(:designer)

      expect(DesignerMailer).to receive(:portfolio_approved).with(user: designer.user).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_now) }
      )

      ApprovePortfolioJob.perform_now(designer.id, designer.count_of_approved_states)
    end

    it 'not sends mailer' do
      designer = create(:designer)

      expect(DesignerMailer).not_to receive(:portfolio_approved)

      ApprovePortfolioJob.perform_now(designer.id, designer.count_of_approved_states - 1)
    end
  end
end
