# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckProjectsJob do
  describe '#perform' do
    it 'calls ProjectsExpire services' do
      expect_any_instance_of(ProjectsExpire).to receive(:call)
      subject.perform
    end
  end
end
