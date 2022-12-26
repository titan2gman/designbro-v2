# frozen_string_literal: true

FactoryBot.define do
  factory :project_source_file do
    designer
    source_file
    project
  end
end
