import { combineReducers } from 'redux'
import { FEATURED_IMAGE_UPLOAD_SUCCESS, FEATURED_IMAGE_DESTROY_SUCCESS } from '@actions/featuredImage'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_SUCCESS':
    return action.payload.results.featuredImages || []
  default:
    return state
  }
}

const attributes = (state = {}, action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_SUCCESS':
    if (action.payload.results.featuredImages) {
      const id = action.payload.results.featuredImages[0]

      return action.payload.entities.featuredImages[id]
    } else {
      return {}
    }
  case FEATURED_IMAGE_UPLOAD_SUCCESS:
    return {
      ...state,
      uploadedFileId: action.payload.data.id,
      url: action.payload.data.attributes.file,
    }
  case FEATURED_IMAGE_DESTROY_SUCCESS:
    return {}
  default:
    return state
  }
}

export default combineReducers({
  ids,
  attributes
})
