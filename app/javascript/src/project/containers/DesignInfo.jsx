import { connect } from 'react-redux'

import { getDesign } from '@reducers/designs'

import DesignInfo from '@project/components/DesignInfo'

const mapStateToProps = (state) => {
  const design = getDesign(state)
  const { rating = 0 } = design || {}

  return { rating }
}

export default connect(mapStateToProps)(DesignInfo)
