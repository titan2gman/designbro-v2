import { combineReducers } from 'redux'

// reducers

const ids = (state = [], action) => {
  switch (action.type) {
  case 'LOAD_PORTFOLIO_IMAGES_SUCCESS':
    return action.payload.results.portfolioImages || []
  case 'LOAD_PORTFOLIO_IMAGES_FAILURE':
    return []
  default:
    return state
  }
}

const loaded = (state = false, action) => {
  switch (action.type) {
  case 'LOAD_PORTFOLIO_IMAGES_REQUEST':
    return false
  case 'LOAD_PORTFOLIO_IMAGES_SUCCESS':
    return true
  case 'LOAD_PORTFOLIO_IMAGES_FAILURE':
    return true
  default:
    return state
  }
}

export default combineReducers({
  ids, loaded
})

// helpers

const getPortfolioImages = (state) =>
  state.portfolioImages.ids.map((id) =>
    state.entities.portfolioImages[id].image
  )

const isPortfolioImagesLoaded = (state) =>
  state.portfolioImages.loaded

export { getPortfolioImages, isPortfolioImagesLoaded }
