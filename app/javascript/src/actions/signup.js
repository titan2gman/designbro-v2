import { persistHeaders } from '@utils/auth'

export const onSuccess = (fsa, callback) => (dispatch) => {
  persistHeaders(fsa.meta)

  dispatch({
    type: 'VALIDATE_AUTH_SUCCESS',
    payload: fsa.payload
  })

  if (callback) {
    callback()
  }
}
