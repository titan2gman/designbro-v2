import pick from 'lodash/pick'
import union from 'lodash/union'
import values from 'lodash/values'

import { combineReducers } from 'redux'

// reducers

const ids = (state = [], action) => {
  switch (action.type) {
  case 'LOAD_DIRECT_CONVERSATION_MESSAGES_SUCCESS':
    return action.payload.results.directConversationMessages || []
  case 'DIRECT_CONVERSATION_MESSAGE_RECEIVED':
    return union(state, [action.message.id])
  default:
    return state
  }
}

export default combineReducers({ ids })

// helpers

export const getMessages = ({ entities, directConversation }) => (
  values(pick(entities.directConversationMessages, directConversation.ids))
)
