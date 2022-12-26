import { combineReducers } from 'redux'
import { CHANGE_CLIENT_ATTRIBUTES } from '@actions/client'

const defaultSettings = {
  paymentType: 'credit_card'
}

const settings = (state = defaultSettings, action) => {
  switch (action.type) {
  case 'VALIDATE_AUTH_SUCCESS': {
    const me = action.payload.data

    return {
      paymentType: me.attributes.preferredPaymentMethod || defaultSettings.paymentType
    }
  }

  case CHANGE_CLIENT_ATTRIBUTES: {
    return {
      ...state,
      ...action.payload
    }
  }
  default:
    return state
  }
}

export default combineReducers({
  settings,
})
