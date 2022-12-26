import _ from 'lodash'
import { createSelector } from 'reselect'
import { getCurrentProject } from './projects'

export const getCurrentBrandDna = state => {
  const currentProject = getCurrentProject(state)

  return currentProject && _.get(state.entities.brandDnas, currentProject.brandDna)
}
