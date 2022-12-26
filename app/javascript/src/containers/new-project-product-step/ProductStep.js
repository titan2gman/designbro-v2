import { compose } from 'redux'
import { connect } from 'react-redux'
import _ from 'lodash'
import { withSpinner } from '@components/withSpinner'
import { withNewProjectGuard } from '../../newProjectGuard'

import {
  changeProjectProductAttributes,
} from '@actions/newProject'

import ProductStep from '@components/new-project-product-step/ProductStep'

const mapStateToProps = (state) => {
  const { brandId, isNewBrand, brandName } = state.newProject.stepProductAttributes
  const name = isNewBrand ? brandName : _.get(state.entities.brands, [brandId, 'name'])

  return {
    inProgress: state.products.inProgress || state.brands.inProgress,
    brandName: name,
    currentProductId: state.newProject.stepProductAttributes.productId
  }
}

export default compose(
  connect(mapStateToProps, {
    changeProjectProductAttributes,
  }),
  withSpinner
)(ProductStep)
