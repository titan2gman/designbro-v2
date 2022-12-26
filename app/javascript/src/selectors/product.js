import _ from 'lodash'
import { createSelector } from 'reselect'
import { getCurrentProject } from './projects'
import { getProjectBuilderAttributes } from './projectBuilder'

const getAllProducts = state => state.entities.products || {}

export const getActiveProducts = (state) => {
  return _.values(state.entities.products).filter((product) => product.active)
}

export const currentProductSelector = createSelector(
  [getAllProducts, getCurrentProject, getProjectBuilderAttributes],
  (products, project, projectBuilder) => (project && products[project.product]) || _.get(products, projectBuilder.productId)
)

export const projectBuilderProductSelector = createSelector(
  [getAllProducts, getProjectBuilderAttributes],
  (products, projectBuilder) => _.get(products, projectBuilder.productId)
)

export const currentProductKeySelector = createSelector(
  currentProductSelector,
  (product) => product && product.key
)

export const currentProductShortNameSelector = createSelector(
  currentProductSelector,
  (product) => product && product.shortName
)

export const currentProductNameSelector = createSelector(
  currentProductSelector,
  (product) => product && product.name
)

export const currentProductCategoryNameSelector = createSelector(
  currentProductSelector,
  (product) => product && product.productCategoryName
)

export const currentProductIdSelector = createSelector(
  currentProductSelector,
  (product) => product && parseInt(product.id, 10)
)

export const getProductCategoriesWithoutOther = (state) => {
  return _.filter(state.entities.productCategories, (category) => category.name !== 'Other')
}
