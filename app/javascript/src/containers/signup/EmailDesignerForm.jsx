import { connect } from 'react-redux'

import clearForm from '@utils/clearForm'
import { onSuccess } from '@actions/signup'
import { signupEmail } from '@actions/auth'
import showServerErrors from '@utils/errors'

import SignupEmailDesignerForm from '@components/signup/EmailDesignerForm'

const onSubmit = signupEmail.bind(null, 'designer')
const onError = showServerErrors('forms.signup')

const SelfClearingSignupEmailDesignerForm =
  clearForm('forms.signup')(SignupEmailDesignerForm)

const mapDispatchToProps = {
  onError,
  onSubmit,
  onSuccess
}

export default connect(null, mapDispatchToProps)(
  SelfClearingSignupEmailDesignerForm
)
