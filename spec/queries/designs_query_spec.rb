# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DesignsQuery do
  let!(:client_that_blocked) { create(:client) }
  let!(:client_that_did_not_block) { create(:client) }

  let!(:project_of_client_that_blocked) do
    create(:project, client: client_that_blocked)
  end

  let!(:project_of_client_that_did_not_block) do
    create(:project, client: client_that_did_not_block)
  end

  let(:blocked_designer) { create(:designer) }
  let(:non_blocked_designer) { create(:designer) }

  let!(:designer_client_block) do
    create(
      :designer_client_block,
      designer: blocked_designer,
      client: client_that_blocked
    )
  end

  let!(:blocked_designs) do
    [
      create(
        :design,
        designer: blocked_designer,
        project: project_of_client_that_blocked
      )
    ]
  end

  let!(:non_blocked_designs) do
    [
      create(
        :design,
        designer: blocked_designer,
        project: project_of_client_that_did_not_block
      ),
      create(
        :design,
        designer: non_blocked_designer,
        project: project_of_client_that_did_not_block
      ),
      create(
        :design,
        designer: non_blocked_designer,
        project: project_of_client_that_blocked
      )
    ]
  end

  context 'blocked' do
    subject { DesignsQuery::Blocked.call }
    it { is_expected.to match_array blocked_designs }
  end

  context 'non blocked' do
    subject { DesignsQuery::NonBlocked.call }
    it { is_expected.to match_array non_blocked_designs }
  end
end
