import { connect } from 'react-redux'
import _ from 'lodash'

import {
  changeProjectProductAttributes,
} from '@actions/newProject'

import ProductsList from '@components/new-project-product-step/ProductsList'

const mapStateToProps = (state) => {
  const products = _.values(state.entities.products).filter((product) => product.active)

  return {
    products,
    currentProductId: state.newProject.stepProductAttributes.productId
  }
}

export default connect(mapStateToProps, {
  changeProjectProductAttributes,
})(ProductsList)
