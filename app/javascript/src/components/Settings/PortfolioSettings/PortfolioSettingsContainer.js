import { connect } from 'react-redux'

import { getMe } from '@reducers/me'
import PortfolioSettings from './PortfolioSettings'

const mapStateToProps = (state) => {
  return {
    attributes: state.designer.profileAttributes
  }
}

export default connect(mapStateToProps, {
})(PortfolioSettings)

