# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QueueSpotReserver do
  describe '#call' do
    let(:project) { create(:project) }

    subject { QueueSpotReserver.new(project: project) }

    it 'reserves spots from queue' do
      create_list(:in_queue_spot, 2, project: project)

      expect { subject.call }.to change { project.reserved_spots.count }.by(2)
    end

    it 'reserves spots only to 10' do
      create_list(:reserved_spot, 2, project: project)
      create_list(:in_queue_spot, 2, project: project)

      expect { subject.call }.to change { project.reserved_spots.count }.by(1)
    end
  end
end
