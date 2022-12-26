import { connect } from 'react-redux'
import { showBrandsModal } from '@actions/modal'

import BrandSwitcher from './BrandSwitcher'

export default connect(null, {
  handleBrandSwitch: showBrandsModal
})(BrandSwitcher)
