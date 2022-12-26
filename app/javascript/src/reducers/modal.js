import pick from 'lodash/pick'
import { LOCATION_CHANGE } from 'connected-react-router'

const initialState = {
  modalType: null,
  modalProps: {}
}

const modal = (state = initialState, action) => {
  switch (action.type) {
  case 'SHOW_MODAL':
    return pick(action, [
      'modalProps',
      'modalType'
    ])
  case 'HIDE_MODAL':
  case LOCATION_CHANGE:
    return initialState
  default:
    return state
  }
}

export default modal

export const getModal = (state) => state.modal
