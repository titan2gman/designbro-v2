import { connect } from 'react-redux'

import clearForm from '@utils/clearForm'
import { onSuccess } from '@actions/signup'
import { signupEmail } from '@actions/auth'
import showServerErrors from '@utils/errors'

import SignupEmailClientForm from '@components/signup/EmailClientForm'

const onError = showServerErrors('forms.signup')
const onSubmit = signupEmail.bind(null, 'client')

const SelfClearingSignupEmailClientForm =
  clearForm('forms.signup')(SignupEmailClientForm)

const mapDispatchToProps = {
  onError,
  onSubmit,
  onSuccess
}

export default connect(null, mapDispatchToProps)(
  SelfClearingSignupEmailClientForm
)
