# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchedClientProjectsQuery do
  describe '#search' do
    let!(:client) { create(:client) }
    let!(:project) { create(:logo_project, client: client, state: Project::STATE_DESIGN_STAGE, name: 'My favorite project') }
    let!(:projects) { create_list(:packaging_project, 2, client: client) }

    context 'with param state_in' do
      let(:params) do
        {
          projects: Project.all,
          search_params: { 'state_in' => ['design_stage'] }
        }
      end
      subject { SearchedClientProjectsQuery.new(params) }
      it 'returns searched projects' do
        expect(subject.search).to match_array([project])
      end
    end

    context 'with param project_type_eq' do
      let(:params) do
        {
          projects: Project.all,
          search_params: { 'project_type_eq' => 'logo' }
        }
      end
      subject { SearchedClientProjectsQuery.new(params) }
      it 'returns searched projects' do
        expect(subject.search).to match_array([project])
      end
    end

    context 'with param name_cont' do
      let(:params) do
        {
          projects: Project.all,
          search_params: { 'name_cont' => 'favor' }
        }
      end
      subject { SearchedClientProjectsQuery.new(params) }
      it 'returns searched projects' do
        expect(subject.search).to match_array([project])
      end
    end

    context 'with sort param' do
      let(:params) do
        {
          projects: Project.all,
          sort_params: ['spots_count desc']
        }
      end

      subject { SearchedClientProjectsQuery.new(params) }

      it 'returns first project' do
        create(:spot, project: project)
        expect(subject.search.first).to eq(project)
      end

      it "doesn't return first project" do
        create(:design, project: projects.first)
        expect(subject.search.first).not_to eq(project)
      end
    end

    context 'with free spots_state' do
      let(:params) do
        {
          projects: Project.all,
          spots_state: 'free'
        }
      end
      subject { SearchedClientProjectsQuery.new(params) }
      it 'returns free project' do
        allow(Project).to receive(:spots_free).and_return(Project.where(id: project.id))
        expect(subject.search).to match_array([project])
      end
    end

    context 'without params' do
      let(:params) do
        {
          projects: Project.all
        }
      end
      subject { SearchedClientProjectsQuery.new(params) }
      it 'returns all projects' do
        expect(subject.search).to match_array(Project.all)
      end
    end
  end
end
