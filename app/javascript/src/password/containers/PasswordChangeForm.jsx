import { connect } from 'react-redux'

import clearForm from '@utils/clearForm'
import showServerErrors from '@utils/errors'
import { open } from '@actions/simpleModal'

import { changePassword } from '@actions/auth'

import PasswordChangeForm from '@password/components/PasswordChangeForm'

const onSubmit = changePassword

const onSuccess = () =>
  open({ title: 'Success', message: 'Password was successfully changed!' })

const onError = showServerErrors('forms.changePassword')

const SelfClearingPasswordChangeForm =
  clearForm('forms.changePassword')(
    PasswordChangeForm
  )

export default connect(null, {
  onSubmit, onSuccess, onError
})(SelfClearingPasswordChangeForm)
