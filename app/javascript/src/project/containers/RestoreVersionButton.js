import partial from 'lodash/partial'

import { connect } from 'react-redux'

import { open } from '@actions/simpleModal'
import { getSelectedVersion } from '@reducers/designVersions'

import RestoreVersionButton from '@project/components/RestoreVersionButton'

const mapStateToProps = (state) => ({
  selectedDesignId: getSelectedVersion(state)
})

export default connect(mapStateToProps, {
  open
})(RestoreVersionButton)
