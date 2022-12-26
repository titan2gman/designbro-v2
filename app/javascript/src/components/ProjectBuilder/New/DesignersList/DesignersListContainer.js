import { connect } from 'react-redux'

import DesignersList from './DesignersList'
import { getFinalistDesigners } from '@selectors/finalistDesigners'

const mapStateToProps = (state) => {
  return {
    winners: getFinalistDesigners(state)
  }
}

export default connect(mapStateToProps)(DesignersList)
