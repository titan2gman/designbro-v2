# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SourceFileForm do
  describe '#save' do
    context 'project in files stage' do
      it 'change project state to review files' do
        project = create(:project, state: Project::STATE_FILES_STAGE)
        designer = create(:designer)
        source_file = create(:source_file)
        form = SourceFileForm.new(project: project, designer: designer, source_file: source_file)

        form.save

        expect(project.state).to eq('review_files')
      end
    end
  end
end
