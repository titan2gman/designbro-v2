# frozen_string_literal: true

RSpec.describe DesignEliminator do
  describe '.call' do
    let(:design) { create(:design) }

    subject { DesignEliminator.new(design) }

    it 'eliminates design' do
      eliminated_design = subject.call

      expect(eliminated_design).to eq(design)
      expect(eliminated_design.spot.eliminated?).to be_truthy
    end

    it 'reserves spot from queue' do
      spot = create(:in_queue_spot, project: design.project)

      expect { subject.call }.to change { design.reload.project.spots.reserved.count }.by(1)

      expect(spot.reload.state).to eq(Spot::STATE_RESERVED.to_s)
    end
  end
end
