# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotifySourceFilesUploadedJob do
  describe '#perform' do
    it do
      expect_any_instance_of(Projects::NotifySourceFilesUploaded).to receive(:call).once
      subject.perform
    end
  end
end
