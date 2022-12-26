import { connect } from 'react-redux'

import { loadVatRates } from '@actions/vatRates'
import { loadNdaPrices } from '@actions/ndaPrices'
import { loadProducts } from '@actions/products'
import { loadTestimonial } from '@actions/testimonial'

import Checkout from './Checkout'

const mapStateToProps = (state) => {
  const inProgress = state.ndaPrices.inProgress || state.vatRates.inProgress || state.products.inProgress

  return {
    inProgress
  }
}

export default connect(mapStateToProps, {
  loadVatRates,
  loadNdaPrices,
  loadProducts,
  loadTestimonial
})(Checkout)
