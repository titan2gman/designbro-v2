import _ from 'lodash'
import { connect } from 'react-redux'
import { getProjectBuilderAttributes } from '@selectors/projectBuilder'
import { getMe } from '@selectors/me'
import { showGetQuoteModal } from '@actions/modal'

import Header from './Header'

const mapStateToProps = (state) => {
  const attributes = getProjectBuilderAttributes(state)
  const brandId = attributes.brandId

  return {
    brandName: _.get(state.entities.brands, [brandId, 'name']) || attributes.brandName || 'New brand',
    isRequestManualVisible: !!getMe(state).id
  }
}

export default connect(mapStateToProps, {
  showGetQuoteModal
})(Header)
