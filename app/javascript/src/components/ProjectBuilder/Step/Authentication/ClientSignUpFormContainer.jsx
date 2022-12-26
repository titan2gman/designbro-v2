import { connect } from 'react-redux'
import { actions } from 'react-redux-form'

import { update } from '@actions/user'
import { signupEmail } from '@actions/auth'
import { onSuccess } from '@actions/signup'
import showServerErrors from '@utils/errors'
import { getMe, isAuthenticated } from '@reducers/me'

import ClientSignUpForm from './ClientSignUpForm'

const isContinueBtn = (target) => target && target.id === 'continue-btn'

const onFormInputBlur = (e) => (dispatch, getState) => {
  const state = getState()

  const successCallback = () => {
    if (isContinueBtn(e.relatedTarget)) {
      e.relatedTarget.click()
    }
  }

  if (isAuthenticated(state)) {
    const updateForm = state.forms.signup

    dispatch(actions.setValidity('forms.signup.email', true))

    dispatch(actions.submit('forms.signup')).then(() => {
      if (!getState().forms.forms.signup.$form.submitFailed) {

        dispatch(update(getMe(state).userId, updateForm)).then((response) => {
          if (response.error) {
            dispatch(showServerErrors('forms.signup')(response))
          } else {
            dispatch(onSuccess(response, successCallback))
          }
        })
      }
    })
  } else {
    const signupForm = state.forms.signup

    dispatch(actions.setValidity('forms.signup.email', true))

    dispatch(actions.submit('forms.signup')).then(() => {
      if (!getState().forms.forms.signup.$form.submitFailed) {

        dispatch(signupEmail('client', signupForm)).then((response) => {
          if (response.error) {
            dispatch(showServerErrors('forms.signup')(response))
          } else {
            dispatch(onSuccess(response, successCallback))
          }
        })
      }
    })
  }
}

const mapDispatchToProps = {
  onFormInputBlur
}

export default connect(null, mapDispatchToProps)(ClientSignUpForm)
