import { createSelector } from 'reselect'
import { getProjectStateGroup } from '@utils/projectStates'
import _ from 'lodash'

const projectEntitiesSelector = state => state.entities.projects

export const groupedByStateProjectsSelector = brandId => createSelector(
  [projectEntitiesSelector],
  (projects) => _.groupBy(
    _.filter(projects, (project) => project.brand === brandId),
    getProjectStateGroup
  )
)

export const getCurrentProject = state => {
  return _.get(state.entities.projects, state.projects.current)
}

export const getProjectCreator = (state) => {
  return _.get(state.entities.clients, _.get(getCurrentProject(state), 'creator'))
}
