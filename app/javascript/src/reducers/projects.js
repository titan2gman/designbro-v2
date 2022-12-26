import { combineReducers } from 'redux'
import includes from 'lodash/includes'

const current = (state = null, action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_REQUEST':
  case 'PROJECT_CREATE_REQUEST':
    return null
  case 'PROJECT_LOAD_SUCCESS':
  case 'PROJECT_CREATE_SUCCESS':
    return action.payload.results.projects[0]
  default:
    return state
  }
}

const ids = (state = [], action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_SUCCESS':
  case 'PROJECT_CREATE_SUCCESS':
  case 'PROJECTS_LOAD_SUCCESS':
  case 'LOAD_DESIGNER_NDAS_SUCCESS':
    return action.payload.results.projects || []
  default:
    return state
  }
}

const inProgress = (state = true, action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_REQUEST':
  case 'PROJECTS_LOAD_REQUEST':
    return true
  case 'PROJECT_LOAD_SUCCESS':
  case 'PROJECT_CREATE_SUCCESS':
  case 'PROJECTS_LOAD_SUCCESS':
  case 'PROJECT_LOAD_FAILURE':
  case 'PROJECT_CREATE_FAILURE':
  case 'PROJECTS_LOAD_FAILURE':
    return false
  default:
    return state
  }
}

const projectLoaded = (state = false, action) => {
  switch (action.type) {
  case 'PROJECT_LOAD_REQUEST':
    return false
  case 'PROJECT_LOAD_SUCCESS':
  case 'PROJECT_CREATE_SUCCESS':
    return true
  default:
    return state
  }
}

const projectsLoaded = (state = false, action) => {
  switch (action.type) {
  case 'PROJECTS_LOAD_REQUEST':
    return false
  case 'PROJECTS_LOAD_SUCCESS':
    return true
  default:
    return state
  }
}

const pager = (state = { currentPage: 0, totalPages: 0 }, action) => {
  switch (action.type) {
  case 'PROJECTS_LOAD_SUCCESS':
    return action.payload.meta || state
  case 'PROJECTS_CHANGE_PAGE':
    return {
      ...state,
      currentPage: action.page
    }
  default:
    return state
  }
}

const prizeFilter = (state = 'default', action) => {
  switch (action.type) {
  case 'PROJECTS_CHANGE_PRIZE_FILTER':
    return action.filter
  default:
    return state
  }
}

const stateFilter = (state = 'all', action) => {
  switch (action.type) {
  case 'PROJECTS_CHANGE_STATE_FILTER':
    return action.filter
  default:
    return state
  }
}

const nameFilter = (state = '', action) => {
  switch (action.type) {
  case 'PROJECTS_CHANGE_NAME_FILTER':
    return action.name
  default:
    return state
  }
}

export default combineReducers({
  ids,
  pager,
  inProgress,
  current,
  nameFilter,
  stateFilter,
  prizeFilter,
  projectLoaded,
  projectsLoaded
})

export const getProjectType = (type = '') => {
  switch (type) {
  case 'logo':
    return 0
  case 'brand-identity':
    return 1
  case 'packaging':
    return 2
  default:
    return type
  }
}

export const getSpotState = (spotState) => {
  switch (spotState) {
  case 'with free spots':
    return 'free'
  case 'without free spots':
    return 'taken'
  default:
    return ''
  }
}

export const getPrize = (prize) => {
  switch (prize) {
  case 'prize low-high':
    return 'normalized_price asc'
  case 'prize high-low':
    return 'normalized_price desc'
  case 'popular first':
    return 'spots_count desc'
  case 'new first':
    return 'created_at desc'
  default:
    return ''
  }
}

export const getProjectById = (state, id) => {
  if (includes(state.projects.ids, id)) {
    return state.entities.projects[id]
  }
}

export const getStateFilter = (state) =>
  state.projects.stateFilter

export const getPrizeFilter = (state) =>
  state.projects.prizeFilter

export const getNameFilter = (state) =>
  state.projects.nameFilter

export const getProjects = ({ entities, projects }) =>
  projects.ids.map((id) => entities.projects[id])

export const getProject = ({ entities, projects }) => (
  entities.projects[projects.current]
)

export const getProjectLoaded = (state) => (
  state.projects.projectLoaded
)

export const getProjectsLoaded = (state) => (
  state.projects.projectsLoaded
)

export const getProjectsPager = ({ projects: { pager } }) => ({
  current: pager.currentPage, total: pager.totalPages
})

export const getCurrentProject = ({ entities: { projects }, projects: { current } }) =>
  projects && projects[current]
