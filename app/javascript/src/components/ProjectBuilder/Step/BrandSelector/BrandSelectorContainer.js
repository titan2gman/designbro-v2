import _ from 'lodash'
import { connect } from 'react-redux'

import { loadAllBrands } from '@actions/brands'

import {
  getProjectBuilderAttributes
} from '@selectors/projectBuilder'

import BrandSelector from './BrandSelector'

const mapStateToProps = (state, { match }) => {
  const attributes = getProjectBuilderAttributes(state)

  return {
    brand: _.get(state, ['entities', 'brands', attributes.brandId], {}),
  }
}

export default connect(mapStateToProps, {
  loadAllBrands
})(BrandSelector)
