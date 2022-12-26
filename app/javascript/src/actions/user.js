import api from '@utils/api'

export const update = (id, params) =>
  api.patch({
    endpoint: `/api/v1/users/${id}`,
    body: { user: params },
    types: ['USER_UPDATE_REQUEST', 'USER_UPDATE_SUCCESS', 'USER_UPDATE_FAILURE']
  })

export const approve = (id) =>
  api.patch({
    endpoint: `/api/v1/users/${id}`,
    body: { user: { approve: true } },
    types: ['USER_UPDATE_REQUEST', 'USER_UPDATE_SUCCESS', 'USER_UPDATE_FAILURE']
  })
