# frozen_string_literal: true

RSpec.describe DesignerStatsListener do
  describe '#send_designer_stats_entity' do
    it 'broadcasts DesignerStatsChannel' do
      expect(DesignerStatsChannel).to receive(:broadcast).and_return(true)

      listener = DesignerStatsListener.new
      project  = create(:project, state: Project::STATE_DESIGN_STAGE)
      design   = create(:design, project: project)

      listener.send_designer_stats_entity(design)
    end
  end
end
