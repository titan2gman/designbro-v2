import { connect } from 'react-redux'

import { confirmationResend } from '@actions/auth'

import SignupResendConfirmationForm from '@components/signup/ResendConfirmationForm'

export default connect(null, {
  confirmationResend
})(SignupResendConfirmationForm)
