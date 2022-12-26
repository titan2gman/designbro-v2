import { connect } from 'react-redux'

import { getDesignUploaded } from '@reducers/designs'

import ReplaceDesignBtn from '@project/components/design-buttons-bar/ReplaceDesignBtn'

const mapStateToProps = (state) => ({
  visible: getDesignUploaded(state)
})

export default connect(mapStateToProps)(ReplaceDesignBtn)
