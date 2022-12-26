import { combineReducers } from 'redux'

// reducers

const ids = (state = [], action) => {
  switch (action.type) {
  case 'LOAD_FAQ_ITEM_SUCCESS':
  case 'LOAD_FAQ_GROUPS_SUCCESS':
    return action.payload.results.faqGroups || []
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

const getFaqGroupsLoaded = (state) => state.faqGroups.loaded
const getFaqGroupsLoading = (state) => state.faqGroups.loading

const getFaqGroups = (state) =>
  state.faqGroups.ids.map((id) =>
    state.entities.faqGroups[id]
  )

const getFaqGroupById = (state, id) =>
  state.entities.faqGroups[id]

const getFaqGroupsByIds = (state, ids) =>
  ids.map((id) => getFaqGroupById(state, id))

const getFaqGroupByFaqItem = (state, faqItem) =>
  faqItem ? getFaqGroupById(state, faqItem.faqGroup) : null

export {
  getFaqGroups,
  getFaqGroupById,
  getFaqGroupsByIds,
  getFaqGroupsLoaded,
  getFaqGroupsLoading,
  getFaqGroupByFaqItem
}
