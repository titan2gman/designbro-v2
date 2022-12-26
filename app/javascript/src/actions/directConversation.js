import api from '@utils/api'

import { getFileData, getMultipleFileData } from '@utils/fileUtilities'

import { applyNormalize } from '@utils/normalizer'

export const loadMessages = (projectId, designId) => api.get({
  endpoint: `/api/v1/projects/${projectId}/designs/${designId}/messages`,
  normalize: true,

  types: [
    'LOAD_DIRECT_CONVERSATION_MESSAGES_REQUEST',
    'LOAD_DIRECT_CONVERSATION_MESSAGES_SUCCESS',
    'LOAD_DIRECT_CONVERSATION_MESSAGES_FAILURE'
  ]
})

export const sendMessage = (projectId, designId, value) => api.post({
  endpoint: `/api/v1/projects/${projectId}/designs/${designId}/messages`,
  body: getMultipleFileData(value),
  normalize: true,

  types: [
    'SEND_DIRECT_CONVERSATION_MESSAGES_REQUEST',
    'SEND_DIRECT_CONVERSATION_MESSAGES_SUCCESS',
    'SEND_DIRECT_CONVERSATION_MESSAGES_FAILURE'
  ]
})

export const cleanDirectConversationMessages = () => ({
  type: 'CLEAN_DIRECT_CONVERSATION_MESSAGES'
})

export const messageReceived = applyNormalize((message) => (dispatch, getState) => {
  const { me } = getState()

  if (message.type === 'directConversationMessages' || message.user === me.userId.toString()) {
    return dispatch({ type: 'DIRECT_CONVERSATION_MESSAGE_RECEIVED', message })
  }
})
