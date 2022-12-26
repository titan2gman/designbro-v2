import delay from 'lodash/delay'

import { connect } from 'react-redux'
import { actions } from 'react-redux-form'
import { bindActionCreators } from 'redux'

import { createReview } from '@actions/reviews'
import { hideModal, showModal } from '@actions/modal'

import clearForm from '@utils/clearForm'

import LeaveReviewModal from '@modals/leave-review/components/LeaveReviewModal'

const onConfirm = ({ design, project }) => () => (dispatch, getState) => {
  const review = getState().forms.review
  const data = { ...review, designId: design.id }

  dispatch(createReview(data)).then((response) => {
    if (response.error) {
      return dispatch(
        actions.setSubmitFailed(
          'forms.review'
        )
      )
    }

    dispatch(hideModal())

    delay(() => dispatch(
      showModal('START_NEW_PROJECT', {
        project
      })),
    5000)
  })
}

const mapDispatchToProps = (dispatch, props) => bindActionCreators({
  onClose: hideModal, onConfirm: onConfirm(props)
}, dispatch)

const SelfClearingLeaveReviewModal = (
  clearForm('forms.review')(
    LeaveReviewModal
  )
)

export default connect(null, mapDispatchToProps)(
  SelfClearingLeaveReviewModal
)
