# frozen_string_literal: true

class IntercomConversationCreator
  def initialize(content:, email:)
    @intercom = Intercom::Client.new(token: ENV.fetch('INTERCOM_TOKEN'))
    @content = content
    @email = email
  end

  def call
    intercom.messages.create(
      from: {
        type: 'user',
        id: contact.id
      },
      body: content
    )
  end

  attr_reader :intercom, :content, :email

  private

  def contact
    existing_contact || new_contact
  end

  def existing_contact
    intercom.contacts.search(
      "query": {
        "field": 'email',
        "operator": '=',
        "value": email
      }
    ).first
  end

  def new_contact
    intercom.contacts.create(email: email, role: 'user')
  end
end
