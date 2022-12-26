import { connect } from 'react-redux'
import { actions } from 'react-redux-form'

import MaterialStarRating from '@components/inputs/MaterialStarRating'

const mapDispatchToProps = (dispatch, ownProps) => ({
  onChange: (model) => (value) => {
    dispatch(actions.change(model, value))
    if (ownProps.onChange) {
      ownProps.onChange()
    }
  }
})

export default connect(null, mapDispatchToProps)(
  MaterialStarRating
)
