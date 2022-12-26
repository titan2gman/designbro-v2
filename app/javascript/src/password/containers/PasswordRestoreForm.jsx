import { connect } from 'react-redux'
import { history } from '../../history'

import clearForm from '@utils/clearForm'
import showServerErrors from '@utils/errors'
import { showServerErrors as validationErrors } from '@utils/form'

import { restorePassword } from '@actions/auth'

import PasswordRestoreForm from '@password/components/PasswordRestoreForm'

const onSubmit = restorePassword
const onSuccess = () => history.push('/password-restored')

const onError = showServerErrors(null, {
  404: validationErrors('forms.restorePassword')
})

const SelfClearingPasswordRestoreForm =
  clearForm('forms.restorePassword')(
    PasswordRestoreForm
  )

export default connect(null, {
  onSubmit, onSuccess, onError
})(SelfClearingPasswordRestoreForm)
