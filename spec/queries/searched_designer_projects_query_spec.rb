# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchedDesignerProjectsQuery do
  subject { described_class.new(params) }

  describe '#search' do
    let!(:client) { create(:client) }

    context 'filters' do
      let!(:project) { create(:logo_project, client: client, state: Project::STATE_DESIGN_STAGE, name: 'My favorite project') }
      let!(:projects) { create_list(:packaging_project, 2, client: client) }

      context 'with param state_in' do
        let(:params) do
          {
            projects: Project.all,
            search_params: { 'state_in' => ['design_stage'] }
          }
        end

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

        it 'returns searched projects' do
          expect(subject.search).to match_array([project])
        end
      end

      context 'with free spots_state' do
        let(:params) do
          {
            projects: Project.all,
            spots_state: 'free'
          }
        end

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

        it 'returns all projects' do
          expect(subject.search).to match_array(Project.all)
        end
      end
    end

    context 'sorting' do
      let(:time_now) { Time.current.change(usec: 0) }
      let(:one_day_after) { time_now + 1.day }
      let(:two_day_after) { time_now + 2.day }
      let(:project_1) { create(:project, project_type: :logo, state: Project::STATE_DESIGN_STAGE, max_spots_count: 3, created_at: time_now) } # 10 spots available
      let(:project_2) { create(:project, project_type: :logo, state: Project::STATE_DESIGN_STAGE, max_spots_count: 3, created_at: one_day_after) } # 3 spots available
      let(:spots_project_1) { create_list(:reserved_spot, 1, project: project_1) }
      let(:not_visble_spots_project_1) { create_list(:in_queue_spot, 4, project: project_1) }
      let(:spots_project_2) { create_list(:reserved_spot, 2, project: project_2) }
      let(:params) do
        {
          projects: Project.all,
          sort_params: sort_params
        }
      end

      context 'created_at' do
        let(:sort_params) { ['created_at desc'] }
        let(:expected_order) { [project_2.id, project_1.id] }

        before do
          project_1
          project_2
        end

        it do
          result = subject.search
          expect(result.pluck(:id)).to eq expected_order
        end
      end

      context 'spots_count' do
        let(:sort_params) { ['spots_count desc'] }
        let(:expected_order) { [project_2.id, project_1.id] }

        before do
          spots_project_1
          spots_project_2
        end

        it do
          result = subject.search
          expect(result.pluck(:id)).to eq expected_order
        end
      end

      context 'normalized_type_price' do
        before do
          project_1.update_column(:normalized_price, 1)
          project_2.update_column(:normalized_price, 2)
        end

        context 'asc' do
          let(:sort_params) { ['normalized_price asc'] }
          let(:expected_order) { [project_1.id, project_2.id] }

          it do
            result = subject.search
            expect(result.pluck(:id)).to eq expected_order
          end
        end

        context 'desc' do
          let(:sort_params) { ['normalized_price desc'] }
          let(:expected_order) { [project_2.id, project_1.id] }

          it do
            result = subject.search
            expect(result.pluck(:id)).to eq expected_order
          end
        end
      end

      context 'default sort' do
        let(:sort_params) { [] }
        let(:project_3) do # 0 spots available
          create(:project, project_type: :logo,
                           state: Project::STATE_DESIGN_STAGE,
                           max_spots_count: 3,
                           design_stage_started_at: time_now,
                           design_stage_expires_at: one_day_after)
        end
        let(:spots_project_3) { create_list(:reserved_spot, 3, project: project_3) }
        let(:not_visble_spots_project_3) { create_list(:in_queue_spot, 2, project: project_3) }
        let(:project_4) do # 0 spots available
          create(:project, project_type: :logo,
                           state: Project::STATE_DESIGN_STAGE,
                           max_spots_count: 3,
                           design_stage_started_at: time_now,
                           design_stage_expires_at: two_day_after)
        end
        let(:spots_project_4) { create_list(:reserved_spot, 3, project: project_4) }
        let(:not_visble_spots_project_4) { create_list(:in_queue_spot, 1, project: project_4) }
        let(:project_5) do
          create(:project, project_type: :logo,
                           state: Project::STATE_FINALIST_STAGE,
                           max_spots_count: 3,
                           finalist_stage_started_at: time_now,
                           finalist_stage_expires_at: one_day_after)
        end
        let(:project_6) do
          create(:project, project_type: :logo,
                           state: Project::STATE_FINALIST_STAGE,
                           max_spots_count: 3,
                           finalist_stage_started_at: time_now,
                           finalist_stage_expires_at: two_day_after)
        end
        let(:project_7) do
          create(:project, project_type: :logo,
                           state: Project::STATE_FILES_STAGE,
                           max_spots_count: 3,
                           files_stage_started_at: time_now,
                           files_stage_expires_at: one_day_after)
        end
        let(:project_8) do
          create(:project, project_type: :logo,
                           state: Project::STATE_FILES_STAGE,
                           max_spots_count: 3,
                           files_stage_started_at: time_now,
                           files_stage_expires_at: two_day_after)
        end
        let(:expected_order) do
          [
            project_1.id,
            project_2.id,
            project_3.id,
            project_4.id,
            project_5.id,
            project_6.id,
            project_7.id,
            project_8.id
          ]
        end

        before do
          project_8
          project_7
          project_6
          project_5
          spots_project_4
          not_visble_spots_project_4
          spots_project_3
          not_visble_spots_project_3
          spots_project_2
          spots_project_1
          not_visble_spots_project_1
        end

        it do
          result = subject.search
          expect(result.pluck(:id)).to eq expected_order
        end
      end
    end
  end
end
