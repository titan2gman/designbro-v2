import values from 'lodash/values'
import filter from 'lodash/filter'

import { combineReducers } from 'redux'

// reducers

const ids = (state = [], action) => {
  switch (action.type) {
  case 'LOAD_FAQ_ITEM_SUCCESS':
  case 'LOAD_FAQ_GROUPS_SUCCESS':
    return action.payload.results.faqItems || []
  default:
    return state
  }
}

const loaded = (state = false, action) => {
  switch (action.type) {
  case 'LOAD_FAQ_ITEM_SUCCESS':
  case 'LOAD_FAQ_GROUPS_SUCCESS':
    return true
  default:
    return state
  }
}

const loading = (state = false, action) => {
  switch (action.type) {
  case 'LOAD_FAQ_ITEM_REQUEST':
  case 'LOAD_FAQ_GROUPS_REQUEST':
    return true
  case 'LOAD_FAQ_ITEM_SUCCESS':
  case 'LOAD_FAQ_GROUPS_SUCCESS':
  case 'LOAD_FAQ_GROUPS_FAILURE':
    return false
  default:
    return state
  }
}

export default combineReducers({
  ids, loaded, loading
})

// helpers

const getLoading = (state) => (
  state.faqItems.loading
)

const getFaqItemsLoaded = (state) => (
  state.faqItems.loaded
)

const getFaqItems = (state) => (
  state.faqItems.ids.map((id) =>
    state.entities.faqItems[id]
  )
)

const getFaqItemsByGroupId = (state, faqGroupId) => (
  filter(values(state.entities.faqItems), { faqGroup: faqGroupId })
)

const getFaqItemById = (state, id) => (
  state.entities.faqItems[id]
)

export {
  getLoading,
  getFaqItems,
  getFaqItemById,
  getFaqItemsLoaded,
  getFaqItemsByGroupId
}
