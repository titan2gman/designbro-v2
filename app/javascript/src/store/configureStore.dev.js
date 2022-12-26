import { createStore, applyMiddleware, compose } from 'redux'
import { apiMiddleware } from 'redux-api-middleware'
import { createLogger } from 'redux-logger'
import rootReducer from '@reducers'
import multi from 'redux-multi'
import thunk from 'redux-thunk'
import { routerMiddleware } from 'connected-react-router'
import { history } from '../history'

const configureStore = preloadedState => {
  const store = createStore(
    rootReducer,
    preloadedState,
    compose(
      applyMiddleware(
        routerMiddleware(history),
        multi,
        thunk,
        apiMiddleware,
        createLogger({ collapsed: true })
      )
    )
  )

  if (module.hot) {
    // Enable Webpack hot module replacement for reducers
    module.hot.accept('../reducers', () => {
      const nextRootReducer = require('../reducers').default
      store.replaceReducer(nextRootReducer)
    })
  }

  window.store = store
  return store
}

export default configureStore
