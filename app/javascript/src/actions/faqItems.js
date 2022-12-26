import api from '@utils/api'

const loadFaqItem = (id) => api.get({
  endpoint: `/api/v1/faq_items/${id}`,
  normalize: true,

  types: [
    'LOAD_FAQ_ITEM_REQUEST',
    'LOAD_FAQ_ITEM_SUCCESS',
    'LOAD_FAQ_ITEM_FAILURE'
  ]
})

export { loadFaqItem }
