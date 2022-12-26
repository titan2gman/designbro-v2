import _ from 'lodash'
import find from 'lodash/find'
import pick from 'lodash/pick'
import filter from 'lodash/filter'
import values from 'lodash/values'
import includes from 'lodash/includes'

import { combineReducers } from 'redux'

import { getMe } from '@reducers/me'

import { REMOVE_BLOCKED_DESIGN } from '@actions/designs'

// reducers:

const spotsIds = (state = [], action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_SUCCESS':
    return action.payload.results.spots || []
  case 'PROJECT_RESERVE_SPOT_SUCCESS':
    return [ ...state, action.payload.results.spots[0]]
  case REMOVE_BLOCKED_DESIGN:
    return _.without(state, action.spotId)
  default:
    return state
  }
}

const spotsLoaded = (state = false, action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_REQUEST':
    return false
  case 'PROJECT_LOAD_SUCCESS':
    return true
  default:
    return state
  }
}

export default combineReducers({
  ids: spotsIds, loaded: spotsLoaded
})

// helpers:

const FINALIST_STATES = [
  'finalist',
  'stationery',
  'stationery_uploaded'
]

const IN_PROGRESS_STATES = [
  'design_uploaded',
  'reserved'
]

const getSpots = ({ entities, spots }) => (
  values(pick(entities.spots, spots.ids))
)

export const getVisibleSpots = (state) => (
  getSpots(state).filter((spot) =>
    includes([
      'winner',
      'reserved',
      'finalist',
      'stationery',
      'design_uploaded',
      'stationery_uploaded'
    ], spot.state)
  )
)

const getWinnerSpots = (state) => (
  getSpots(state).filter((spot) =>
    spot.state === 'winner'
  )
)

export const getMySpot = (state) => (
  find(getVisibleSpots(state), { project: state.projects.current, designer: getMe(state).id }) || {}
)

export const getMySpots = (state) => (
  filter(getVisibleSpots(state), { project: state.projects.current, designer: getMe(state).id })
)

export const getInProgressSpots = (state) => (
  getVisibleSpots(state).filter((spot) =>
    includes(IN_PROGRESS_STATES, spot.state)
  )
)

export const getFinalistsSpots = (state) => (
  getVisibleSpots(state).filter((spot) =>
    includes(FINALIST_STATES, spot.state)
  )
)

export const getCurrentProjectWinner = (state) => (
  find(getWinnerSpots(state), {
    project: state.projects.current
  })
)

export const getSpotsLoaded = (state) => state.spots.loaded

export const getSpotById = (state, id) => {
  if (includes(state.spots.ids, id)) {
    return state.entities.spots[id]
  }
}
