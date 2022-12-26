# frozen_string_literal: true

RSpec.describe ProjectSourceFileListener do
  subject { ProjectSourceFileListener.new }
  let(:project) { create(:project) }

  describe '#new_file_uploaded' do
    it 'delivers new_source_file_uploaded to ClientMailer' do
      expect(ClientMailer).to receive(:new_source_file_uploaded).with(project: project).and_return(
        double('email').tap { |email| expect(email).to receive(:deliver_later) }
      )

      subject.new_file_uploaded(project)
    end
  end
end
