import api from '@utils/api'

export const update = (id, params) =>
  api.patch({
    endpoint: `/api/v1/clients/${id}`,
    body: { client: params },
    types: ['CLIENT_UPDATE_REQUEST', 'CLIENT_UPDATE_SUCCESS', 'CLIENT_UPDATE_FAILURE']
  })

export const CHANGE_CLIENT_ATTRIBUTES = 'CHANGE_CLIENT_ATTRIBUTES'

export const changeAttributes = (data) => ({
  type: CHANGE_CLIENT_ATTRIBUTES,
  payload: data
})

export const saveStripePaymentSettings = (paymentDetails) => (dispatch, getState) => {
  if (paymentDetails) {
    dispatch(changeAttributes({ paymentMethodId: paymentDetails.id }))
  }

  return dispatch(savePaymentSettings())
}

export const savePaymentSettings = () => (dispatch, getState) => {
  const state = getState()

  return dispatch(update(state.me.me.id, state.client.settings))
}

export const savePaymentSettingsFromPopup = (callback) => (dispatch, getState) => {
  const state = getState()

  return dispatch(update(state.me.me.id, state.client.settings)).then(callback)
}
