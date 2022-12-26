# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectForm do
  describe '#save' do
    context 'project in review files state' do
      it 'broadcasts files approved event' do
        project = create(:project, state: Project::STATE_REVIEW_FILES)
        create(:winner_design, project: project)

        form = ProjectForm.new(id: project.id)
        allow(form).to receive(:broadcast)

        form.save

        expect(form).to have_received(:broadcast).with(:approve_files, project)
      end

      it 'change project state to completed' do
        project = create(:project, state: Project::STATE_REVIEW_FILES)
        create(:winner_design, project: project)

        form = ProjectForm.new(id: project.id)
        allow(form).to receive(:broadcast)

        form.save

        expect(form.project.state).to eq('completed')
      end
    end
  end
end
