# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectCompetitorForm do
  describe '#save' do
    subject do
      ProjectCompetitorForm.new(
        id: project_competitor.id,
        upgrade_project_state: true
      )
    end

    let(:project_competitor) { create(:project_competitor) }

    it 'validates name and rate' do
      subject.save
      expect(subject.errors.messages).to eq(name: ['Required.'], rate: ['Required.', 'is not a number'])
    end
  end
end
