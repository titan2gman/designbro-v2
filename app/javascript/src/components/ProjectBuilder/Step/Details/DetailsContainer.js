import { connect } from 'react-redux'

import Details from './Details'

import { loadVatRates } from '@actions/vatRates'
import { loadNdaPrices } from '@actions/ndaPrices'
import { loadProducts } from '@actions/products'
import { loadTestimonial } from '@actions/testimonial'

import { currentProductKeySelector } from '@selectors/product'
import { getCurrentProject } from '@selectors/projects'

const mapStateToProps = (state) => {
  const inProgress = state.ndaPrices.inProgress || state.products.inProgress || state.vatRates.inProgress
  const productKey = currentProductKeySelector(state)
  const project = getCurrentProject(state)

  return {
    inProgress,
    productKey,
    project
  }
}

export default connect(mapStateToProps, {
  loadVatRates,
  loadNdaPrices,
  loadProducts,
  loadTestimonial
})(Details)
