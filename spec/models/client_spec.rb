# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :company }
    it { is_expected.to have_many(:designer_client_blocks).dependent(:destroy) }
  end

  # describe '#last_unfinished_project' do
  #   subject(:client) { create(:client) }
  #
  #   context 'when there are 2 project' do
  #     it 'returns last one' do
  #       create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)
  #       last_project = create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)
  #
  #       expect(subject.last_unfinished_project).to eq(last_project)
  #     end
  #   end
  #
  #   context 'when there are last not unfinished project' do
  #     it 'returns unfinished project' do
  #       unfinished_project = create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)
  #       create(:project, state: Project::STATE_DESIGN_STAGE, client: client)
  #
  #       expect(subject.last_unfinished_project).to eq(unfinished_project)
  #     end
  #   end
  # end
end
