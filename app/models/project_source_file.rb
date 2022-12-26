# frozen_string_literal: true

class ProjectSourceFile < ApplicationRecord
  include Wisper::Publisher

  belongs_to :project
  belongs_to :designer

  has_one :source_file, as: :entity, class_name: 'UploadedFile::SourceFile', validate: true, dependent: :destroy

  validates :project, :designer, :source_file, presence: true
end
