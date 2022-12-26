import api from '@utils/api'

const sendFeedback = (feedback) => api.post({
  endpoint: '/api/v1/feedbacks',
  body: { feedback },

  types: [
    'SEND_FEEDBACK_REQUEST',
    'SEND_FEEDBACK_SUCCESS',
    'SEND_FEEDBACK_FAILURE'
  ]
})

export { sendFeedback }
