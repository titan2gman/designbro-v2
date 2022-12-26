# frozen_string_literal: true

RSpec.describe UserMailer do
  describe '#new_chat_message' do
    let(:designer) { create(:designer) }
    let(:client)   { create(:client) }
    let(:project) { create(:project, client: client) }
    let(:design)  { create(:design, designer: designer, project: project) }

    context 'for client' do
      let(:message) { create(:direct_conversation_message, design: design, user: designer.user) }

      let(:mail) { UserMailer.new_chat_message_created(message: message).deliver }

      it { expect(mail.to).to match_array([client.email]) }
      it { expect(mail.from).to match_array(['chris@designbro.com']) }
      it { expect(mail.subject).to include('You’ve got a new message for your project') }
      it { expect(mail.body.encoded).to include('You’ve got a new message for your project') }
    end

    context 'for designer' do
      let(:message) { create(:direct_conversation_message, design: design, user: client.user) }

      let(:mail) { UserMailer.new_chat_message_created(message: message).deliver }

      it { expect(mail.to).to match_array([designer.email]) }
      it { expect(mail.from).to match_array(['chris@designbro.com']) }
      it { expect(mail.subject).to include('You’ve got a new message for your project') }
      it { expect(mail.body.encoded).to include('You’ve got a new message for your project') }
    end
  end

  describe '#google_plus_functionality_removed' do
    let(:user) { create(:user) }

    let(:mail) { UserMailer.google_plus_functionality_removed(user: user).deliver }

    it { expect(mail.to).to match_array([user.email]) }
    it { expect(mail.from).to match_array(['chris@designbro.com']) }
    it { expect(mail.subject).to eq('New DesignBro password') }
    it { expect(mail.body.encoded).to include('Currently we are removing the ‘login with Google’') }
  end
end
