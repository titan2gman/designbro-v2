# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DesignerBlocker do
  let(:design) { create(:design) }

  let(:designer) { design.designer }
  let(:project)  { design.project }
  let(:client)   { project.client }

  subject { DesignerBlocker.new(design: design) }

  describe '#call' do
    it 'creates_designer_client_block' do
      allow(subject).to receive(:eliminate_designer_spots)

      allow(DesignerMailer).to receive(:designer_blocked).with(design: design).and_return(
        double('email').tap { |email| allow(email).to receive(:deliver_later) }
      )

      expect { subject.call }.to change { DesignerClientBlock.count }.by(1)

      block = DesignerClientBlock.first
      expect(block.client).to eq(client)
      expect(block.designer).to eq(designer)
    end

    it 'sends email notification to designer' do
      allow(subject).to receive(:eliminate_designer_spots)

      expect(DesignerMailer).to receive(:designer_blocked).with(design: design).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.call
    end

    it 'reserves spot from queue' do
      spot = create(:in_queue_spot, project: design.project)

      subject.call

      expect(spot.reload.state).to eq(Spot::STATE_RESERVED.to_s)
    end

    context 'when "max_spots_count" is 10' do
      let(:project) { create(:project, max_spots_count: 10) }

      it 'eliminates designer spots for current client' do
        allow(subject).to receive(:create_designer_client_block)
        expect(DesignerMailer).not_to receive(:design_eliminated)

        states = [
          Spot::STATE_IN_QUEUE,
          Spot::STATE_RESERVED,
          Spot::STATE_DESIGN_UPLOADED,
          Spot::STATE_STATIONERY,
          Spot::STATE_STATIONERY_UPLOADED,
          Spot::STATE_FINALIST
        ].freeze

        spots = states.map do |state|
          create(:spot, designer: designer,
                        project: project,
                        state: state)
        end

        subject.call

        spots.each { |spot| spot.reload.eliminated? }
      end
    end
  end
end
