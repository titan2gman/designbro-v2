import merge from 'lodash/merge'
import { history } from '../history'

import { showServerErrors } from '@utils/form'

export default (form, callbacks = {}) => (fsa) => {
  if (fsa && fsa.payload && fsa.payload.status) {
    const defaultCallbacks = {
      404: () => history.push('/errors/404'),
      422: showServerErrors(form),
      500: () => history.push('/errors/500')
    }

    callbacks = merge(
      defaultCallbacks,
      callbacks
    )

    const status = fsa.payload.status
    const callback = callbacks[status]

    return callback ? callback(fsa) : { type: 'API ERROR', data: fsa }
  }
}
