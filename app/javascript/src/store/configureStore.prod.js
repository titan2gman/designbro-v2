import { createStore, applyMiddleware } from 'redux'
import { apiMiddleware } from 'redux-api-middleware'
import rootReducer from '@reducers'
import multi from 'redux-multi'
import thunk from 'redux-thunk'

const configureStore = preloadedState => createStore(
  rootReducer,
  preloadedState,
  applyMiddleware(
    multi,
    thunk,
    apiMiddleware
  )
)

export default configureStore
