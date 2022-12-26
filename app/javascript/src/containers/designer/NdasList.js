import { compose } from 'redux'
import { connect } from 'react-redux'
import { withSpinner } from '@components/withSpinner'
import { getDesignerNdas } from '@selectors/designerNdas'
import NdasList from '@components/designer/NdasList'

const mapStateToProps = (state) => ({
  inProgress: state.designerNdas.inProgress,
  designerNdas: getDesignerNdas(state)
})

export default compose(
  connect(mapStateToProps),
  withSpinner,
)(NdasList)
