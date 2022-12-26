import { connect } from 'react-redux'

import ComingSoonModal from '@modals/coming-soon/components/ComingSoonModal'

import { hideModal } from '@actions/modal'

import { requestStartNotification } from '@actions/comingSoon'

const mapStateToProps = (state) => ({
  saved: state.comingSoon.saved
})

const mapDispatchToProps = {
  onSubmit: requestStartNotification,
  onClose: hideModal
}

export default connect(mapStateToProps, mapDispatchToProps)(ComingSoonModal)
