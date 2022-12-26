# frozen_string_literal: true

class ProjectSourceFileListener
  def new_file_uploaded(project)
    ClientMailer.new_source_file_uploaded(project: project).deliver_later
  end
end
