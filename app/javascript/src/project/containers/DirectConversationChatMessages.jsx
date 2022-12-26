import React, { Component } from 'react'
import DirectConversationChatMessages from '@project/components/DirectConversationChatMessages'

class DirectConversationChatMessagesContainer extends Component {
  componentDidMount () {
    this.scrollToBottom()
  }

  componentDidUpdate () {
    this.scrollToBottom()
  }

  scrollToBottom () {
    this.bottom.scrollIntoView()
  }

  render () {
    return (
      <div className="conv-chat__body">
        <DirectConversationChatMessages {...this.props} />
        <div className="conv-chat__body-bottom" ref={(el) => { this.bottom = el }} />
      </div>
    )
  }
}

export default DirectConversationChatMessagesContainer
