import { connect } from 'react-redux'

import { getActiveProducts } from '@selectors/product'
import { getMe } from '@selectors/me'

import ProductsList from './ProductsList'

const mapStateToProps = (state) => {
  return {
    products: getActiveProducts(state),
    isRequestManualVisible: !!getMe(state).id
  }
}

export default connect(mapStateToProps)(ProductsList)
