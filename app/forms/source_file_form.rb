# frozen_string_literal: true

class SourceFileForm < BaseForm
  presents :project_source_file

  attribute :project, Project
  attribute :designer, Designer

  attribute :source_file, UploadedFile::SourceFile

  private

  def persist!
    return unless project_source_file.update(params)

    project.upload_files! if project.files_stage?
  end

  def params
    {
      project: project,
      designer: designer,
      source_file: source_file
    }
  end
end
