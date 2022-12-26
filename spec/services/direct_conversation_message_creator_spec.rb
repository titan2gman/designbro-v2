# frozen_string_literal: true

RSpec.describe DirectConversationMessageCreator do
  let(:designer) { create(:designer) }
  let(:client)   { create(:client, user: user) }
  let(:project)  { create(:project, client: client) }
  let(:design)   { create(:design, project: project) }

  let(:message) { build(:direct_conversation_message, design: design, user: designer.user) }

  describe '.call' do
    context 'notifications are enabled' do
      let(:user) { create(:user, notify_messages_received: true) }

      it 'sends email and WebSocket notifications' do
        expect(UserMailer).to receive(:new_chat_message_created).with(message: message).and_return(
          double('email').tap { |email| expect(email).to receive(:deliver_later) }
        )

        expect(DirectConversationChannel)
          .to receive(:broadcast).with(message)

        expect { DirectConversationMessageCreator.call(message) }
          .to change { DirectConversationMessage.count }.by(1)
      end
    end

    context 'notifications are disabled' do
      let(:user) { create(:user, notify_messages_received: false) }

      it 'sends only WebSocket notification' do
        expect(UserMailer).not_to receive(:new_chat_message_created)

        expect(DirectConversationChannel)
          .to receive(:broadcast).with(message)

        expect { DirectConversationMessageCreator.call(message) }
          .to change { DirectConversationMessage.count }.by(1)
      end
    end
  end
end
