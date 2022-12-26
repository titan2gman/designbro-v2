import api from '@utils/api'

export const requestStartNotification = (data) => api.post({
  endpoint: '/api/v1/start_notification_requests',
  body: { startNotificationRequest: data },

  types: [
    'REQUEST_START_NOTIFICATION_REQUEST',
    'REQUEST_START_NOTIFICATION_SUCCESS',
    'REQUEST_START_NOTIFICATION_FAILURE'
  ]
})
