import { combineReducers } from 'redux'

import isEmpty from 'lodash/isEmpty'

import { getCurrentProject, getProjectLoaded } from '@reducers/projects'

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_SUCCESS':
    return action.payload.results.projectColors || []
  default:
    return state
  }
}

export default combineReducers({
  ids
})

export const getColors = (state) =>
  state.projectColors.ids.map((id) =>
    state.entities.projectColors[id]
  )

export const getColorsComment = (state) =>
  getProjectLoaded(state) && getCurrentProject(state).colorsComment

export const isColorsExist = (state) =>
  !isEmpty(getColors(state)) || !isEmpty(getColorsComment(state))
