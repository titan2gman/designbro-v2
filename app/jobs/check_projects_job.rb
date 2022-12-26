# frozen_string_literal: true

class CheckProjectsJob < ApplicationJob
  def perform
    ProjectsExpire.new.call
  end
end
