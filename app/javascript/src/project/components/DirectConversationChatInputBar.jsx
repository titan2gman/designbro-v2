import React, { useCallback, useState } from 'react'
import PropTypes from 'prop-types'
import { Form } from 'react-redux-form'

import { required, tooLongMessage } from '@utils/validators'

import CurrentUserPic from '@containers/CurrentUserPic'
import CurrentUserPicture from '@containers/CurrentUserPicture'
import MaterialTextarea from '@components/inputs/MaterialTextarea'
import ConversationRichInput from '@components/conversation-components/rich-input/ConversationRichInput'

const DirectConversationChatInputBar = ({ onMessageSend, user }) => {
  return (
    <>
      <div className="conv-chat__footer">
        <div className="" style={{ marginRight: '18.8px' }}>
          <CurrentUserPic />
        </div>
        <ConversationRichInput onMessageSend={onMessageSend} user={user}/>
      </div>
    </>
  )}

DirectConversationChatInputBar.propTypes = {
  onMessageSend: PropTypes.func.isRequired
}

export default DirectConversationChatInputBar
