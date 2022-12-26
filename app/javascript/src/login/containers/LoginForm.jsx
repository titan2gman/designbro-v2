import { connect } from 'react-redux'

import { hideAuthForm } from '@actions/me'
import { signinEmail } from '@actions/auth'
import clearForm from '@utils/clearForm'
import showErrors from '@utils/errors'
import { showServerErrors } from '@utils/form'

import LoginForm from '@login/components/LoginForm'

const SelfClearingLoginForm = clearForm('forms.signin')(LoginForm)

const onError = showErrors(null, {
  401: showServerErrors('forms.signin')
})

export default connect(null, {
  signinEmail,
  hideAuthForm,
  onError
})(SelfClearingLoginForm)
