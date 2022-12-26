import api from '@utils/api'
import queryString from 'query-string'
import { getProjectsPager } from '@reducers/projects'

export const loadMyProjects = (scope) => (
  api.get({
    endpoint: `/api/v1/designers/projects?scope=${scope}`,
    normalize: true,

    types: [
      'MY_PROJECTS_LOAD_REQUEST',
      'MY_PROJECTS_LOAD_SUCCESS',
      'MY_PROJECTS_LOAD_FAILURE'
    ]
  })
)

const pureLoadProjects = (params) => api.get({
  endpoint: `/api/v1/projects/search?${queryString.stringify(params, { arrayFormat: 'bracket' })}`,
  normalize: true,

  types: [
    'PROJECTS_LOAD_REQUEST',
    'PROJECTS_LOAD_SUCCESS',
    'PROJECTS_LOAD_FAILURE'
  ]
})

export const loadProjects = (params) => (dispatch, getState) => {
  const projectsPager = getProjectsPager(getState())
  const currentProjectsPage = projectsPager.current

  dispatch(pureLoadProjects({ page: currentProjectsPage, ...params }))
}

const pureLoadDiscoverProjects = (params) => api.get({
  endpoint: `/api/v1/designers/projects/search?${queryString.stringify(params, { arrayFormat: 'bracket' })}`,
  normalize: true,

  types: [
    'PROJECTS_LOAD_REQUEST',
    'PROJECTS_LOAD_SUCCESS',
    'PROJECTS_LOAD_FAILURE'
  ]
})

export const loadDiscoverProjects = (params) => (dispatch, getState) => {
  const projectsPager = getProjectsPager(getState())
  const currentProjectsPage = projectsPager.current

  const stateNotIn = [
    'finalist_stage',
    'review_files',
    'files_stage',
    'completed',
    'cancelled',
    'error'
  ]

  dispatch(pureLoadDiscoverProjects({ page: currentProjectsPage, ...params, state_not_in: stateNotIn }))
}

export const loadProject = (idOrToken) =>
  api.get({
    endpoint: `/api/v1/projects/${idOrToken}`,
    normalize: true,
    types: [
      'PROJECT_LOAD_REQUEST',
      'PROJECT_LOAD_SUCCESS',
      'PROJECT_LOAD_FAILURE'
    ]
  })

export const loadProjectByToken = loadProject

export const changePage = (page) => {
  return {
    type: 'PROJECTS_CHANGE_PAGE',
    page: page
  }
}

export const changePrizeFilter = (filter) => {
  return {
    type: 'PROJECTS_CHANGE_PRIZE_FILTER',
    filter: filter
  }
}

export const changeStateFilter = (filter) => {
  return {
    type: 'PROJECTS_CHANGE_STATE_FILTER',
    filter: filter
  }
}

export const changeNameFilter = (name) => {
  return {
    type: 'PROJECTS_CHANGE_NAME_FILTER',
    name: name
  }
}

export const changeTypeFilter = (typeFilter) => {
  return {
    type: 'PROJECTS_CHANGE_TYPE_FILTER',
    typeFilter: typeFilter
  }
}

export const resetPage = changePage.bind(this, 1)
export const resetNameFilter = changeNameFilter.bind(this, '')
export const resetStateFilter = changeStateFilter.bind(this, 'all')
export const resetPrizeFilter = changePrizeFilter.bind(this, 'default')

export const reserveSpot = (id) => api.post({
  endpoint: `/api/v1/projects/${id}/reserve_spot`,
  normalize: true,
  types: [
    'PROJECT_RESERVE_SPOT_REQUEST',
    'PROJECT_RESERVE_SPOT_SUCCESS',
    'PROJECT_RESERVE_SPOT_FAILURE'
  ]
})

export const joinQueue = (id) => api.post({
  endpoint: `/api/v1/projects/${id}/reserve_spot`,
  normalize: true,
  types: [
    'PROJECT_JOIN_QUEUE_REQUEST',
    'PROJECT_JOIN_QUEUE_SUCCESS',
    'PROJECT_JOIN_QUEUE_FAILURE'
  ]
})

export const approveFiles = (id) => api.patch({
  endpoint: `/api/v1/projects/${id}`,
  normalize: true,
  types: [
    'PROJECT_APPROVE_FILES_REQUEST',
    'PROJECT_APPROVE_FILES_SUCCESS',
    'PROJECT_APPROVE_FILES_FAILURE'
  ]
})
