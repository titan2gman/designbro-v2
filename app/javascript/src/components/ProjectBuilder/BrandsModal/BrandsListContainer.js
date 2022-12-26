import { connect } from 'react-redux'

import BrandsList from './BrandsList'
import { getBrands } from '@selectors/brands'

const mapStateToProps = (state) => ({
  brands: getBrands(state)
})

export default connect(mapStateToProps)(BrandsList)
