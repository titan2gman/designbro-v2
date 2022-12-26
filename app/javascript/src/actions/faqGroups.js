import api from '@utils/api'

const loadFaqGroups = () => api.get({
  endpoint: '/api/v1/faq_groups',
  normalize: true,

  types: [
    'LOAD_FAQ_GROUPS_REQUEST',
    'LOAD_FAQ_GROUPS_SUCCESS',
    'LOAD_FAQ_GROUPS_FAILURE'
  ]
})

export { loadFaqGroups }
