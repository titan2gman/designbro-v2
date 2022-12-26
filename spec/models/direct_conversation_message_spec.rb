# frozen_string_literal: true

RSpec.describe DirectConversationMessage do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :design }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:design) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(2000).is_at_least(1) }
  end

  describe '#addressee' do
    it 'returns client if user is designer' do
      user = create(:designer).user
      client = create(:client)
      project = create(:project, client: client)
      design = create(:design, project: project)
      message = create(:direct_conversation_message, user: user, design: design)

      expect(message.addressee).to eq(client.user)
    end

    it 'returns designer if user is client' do
      user = create(:client).user
      designer = create(:designer)
      design = create(:design, designer: designer)
      message = create(:direct_conversation_message, user: user, design: design)

      expect(message.addressee).to eq(designer.user)
    end
  end
end
