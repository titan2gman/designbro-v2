# frozen_string_literal: true

RSpec.describe 'Projects API' do
  describe 'GET /api/v1/designers/projects' do
    it 'responds with 200 (OK) and returns projects array' do
      designer = create(:designer)
      headers = designer.user.create_new_auth_token
      create_list(:project, 2, state: Project::STATE_DESIGN_STAGE)

      get api_v1_designers_projects_path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('projects/index')
    end

    context 'with query' do
      it 'returns project which name contains query' do
        designer = create(:designer)

        project1 = create(:project_without_nda, state: Project::STATE_DESIGN_STAGE, name: 'joy reactor')
        project2 = create(:project_without_nda, state: Project::STATE_DESIGN_STAGE, name: 'Nuclear Reactor')

        [project1, project2].each do |project|
          create(:free_nda, project: project)
          create(:spot, designer: designer, project: project)
        end

        create(:project, state: Project::STATE_DESIGN_STAGE, name: 'not match')

        params = { name_cont: 'react' }
        headers = designer.user.create_new_auth_token
        get api_v1_designers_projects_path, headers: headers, params: params

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/index')

        ids = json['data'].map { |project| project['id'].to_i }
        expect(ids).to match_array([project1.id, project2.id])
      end
    end

    context 'with state_in' do
      it 'returns only projects which match state_in' do
        designer = create(:designer)

        projects = create_list(:project_without_nda, 2, state: Project::STATE_COMPLETED).each do |project|
          create(:design, project: project, designer: designer)
          create(:free_nda, project: project)
        end

        create_list(:project_without_nda, 2).each do |project|
          create(:free_nda, project: project)
        end

        params = { state_in: ['completed'] }
        headers = designer.user.create_new_auth_token
        get api_v1_designers_projects_path, headers: headers, params: params

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/index')

        ids = json['data'].map { |p| p['id'].to_i }
        expect(ids).to match_array(projects.map(&:id))
      end
    end
  end

  describe 'GET /api/v1/designers/projects/search' do
    context 'with state_in' do
      it 'returns only projects which match state_in' do
        designer = create(:designer)
        headers = designer.user.create_new_auth_token
        projects = create_list(:project, 2, state: 'completed')
        projects.each { |proj| create(:design, project: proj, designer: designer) }
        create_list(:project, 2)

        search_params = { state_in: ['completed'] }
        get search_api_v1_designers_projects_path, headers: headers, params: search_params
        ids = json['data'].map { |p| p['id'].to_i }

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/index')
        expect(ids).to match_array(projects.map(&:id))
      end
    end

    context 'with project_type' do
      it 'returns only projects which match project_type' do
        designer = create(:designer)
        project  = create(:project_without_nda, state: Project::STATE_DESIGN_STAGE, project_type: :packaging)
        projects = create_list(:project_without_nda, 2, state: Project::STATE_DESIGN_STAGE, project_type: :logo)

        [project, *projects].each do |proj|
          create(:free_nda, project: proj)
        end

        params = { project_type_eq: 'logo' }
        headers = designer.user.create_new_auth_token

        get search_api_v1_designers_projects_path, headers: headers, params: params

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/index')

        ids = json['data'].map { |proj| proj['id'].to_i }
        expect(ids).to match_array(projects.map(&:id))
      end
    end

    context 'returns 10 projects' do
      it do
        designer = create(:designer)
        headers = designer.user.create_new_auth_token
        create_list(:project, 11, state: Project::STATE_DESIGN_STAGE).map(&:id)

        get search_api_v1_designers_projects_path, headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/index')
        expect(json['data'].size).to eq 10
      end
    end
  end
end
