# frozen_string_literal: true

RSpec.describe 'ProjectSourceFile API' do
  describe 'GET /projects/:project_id/project_source_files' do
    it 'respond with 200 (OK) and renders source files' do
      designer = create(:designer)
      project  = create(:project, state: Project::STATE_REVIEW_FILES)

      create(:designer_nda, nda: project.nda, designer: designer)
      create(:winner_design, project: project, designer: designer)
      create(:project_source_file, project: project, designer: designer)

      headers = designer.user.create_new_auth_token
      get api_v1_project_project_source_files_path(project), headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('project_source_files/index')
    end

    it 'respond with 200 (OK) and creates zip archive with source files' do
      designer = create(:designer)
      project  = create(:project, state: Project::STATE_REVIEW_FILES)

      create(:designer_nda, nda: project.nda, designer: designer)
      create(:winner_design, project: project, designer: designer)
      create(:project_source_file, project: project, designer: designer)

      headers = designer.user.create_new_auth_token
      get api_v1_project_project_source_files_path(project, format: 'zip'), headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/zip'
    end
  end

  describe 'DELETE /projects/:project_id/project_source_files/:id' do
    it 'responds with 200 (OK)' do
      designer = create(:designer)
      project  = create(:project, state: Project::STATE_REVIEW_FILES)

      project_source_file = create(:project_source_file, project: project, designer: designer)

      create(:designer_nda, nda: project.nda, designer: designer)
      create(:winner_design, project: project, designer: designer)

      headers = designer.user.create_new_auth_token
      delete api_v1_project_project_source_file_path(project, project_source_file), headers: headers

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq('')
    end
  end
end
