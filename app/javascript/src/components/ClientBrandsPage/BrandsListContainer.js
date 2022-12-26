import { connect } from 'react-redux'

import BrandsList from './BrandsList'
import { getBrands } from '@selectors/brands'

const mapStateToProps = (state) => ({
  inProgress: state.brands.inProgress,
  brands: getBrands(state)
})

export default connect(mapStateToProps)(BrandsList)
