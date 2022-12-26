import _ from 'lodash'
import { createSelector } from 'reselect'
import { getCurrentProject } from './projects'

export const getCurrentBrand = state => {
  const currentProject = getCurrentProject(state)

  return currentProject && _.get(state.entities.brands, currentProject.brand)
}

export const getBrandById = (id) => (state) => {
  return _.get(state.entities.brands, id)
}

export const getBrands = (state) => _.map(state.brands.ids, (id) => state.entities.brands[id])

// new project builder
export const brandsSelector = (state) => state.newProjectBuilderBrands.brands
