import React, { useState } from 'react'
import { useDispatch } from 'react-redux'
import cn from 'classnames'
import { Modal } from 'semantic-ui-react'

import Headline from '../Headline'
import Input from '../Input'
import PasswordInput from '../PasswordInput'
import { ContinueButton } from '../Footer'

import { signupEmail } from '@actions/auth'
import { onSuccess } from '@actions/signup'
import { showSignInModal, hideModal } from '@actions/modal'

import { isEmail, isWeak } from '@utils/validators'

import styles from './SignUpModal.module.scss'

const SignUpModal = ({ title, successCallback, optional }) => {
  const dispatch = useDispatch()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  const isValid = email && isEmail(email) && password && isWeak(password)

  const handleSignInClick = () => {
    dispatch(hideModal())
    dispatch(showSignInModal({ successCallback }))
  }

  const handleClose = () => {
    if (optional) {
      successCallback()
    }

    dispatch(hideModal())
  }

  const handleEmailChange = (event) => {
    setEmail(event.target.value)
  }

  const handlePasswordChange = (event) => {
    setPassword(event.target.value)
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    if (optional && !email && !password) {
      successCallback()
    } else {
      dispatch(signupEmail('client', { email, password })).then((response) => {
        if (!response.error) {
          dispatch(onSuccess(response, successCallback))
        }
      })
    }
  }

  return (
    <Modal
      size="tiny"
      open
      className={styles.modal}
    >
      <div className={cn('icon-cross', styles.closeIcon)} onClick={handleClose} />

      <Modal.Content className={styles.modalContent}>
        <Headline>{title}</Headline>

        or login <span className={styles.loginSwitch} onClick={handleSignInClick}>here</span>

        <form onSubmit={handleSubmit}>
          <div className={styles.signUpForm}>
            <Input
              inputClassName={styles.input}
              value={email}
              onChange={handleEmailChange}
              placeholder="Email"
            />

            <PasswordInput
              statusLine
              inputClassName={styles.input}
              type="password"
              value={password}
              onChange={handlePasswordChange}
              placeholder="Password"
            />
          </div>

          <div className={styles.modalFooter}>
            {optional && !email && !password ? (
              <ContinueButton isValid>Skip this step →</ContinueButton>
            ) : (
              <ContinueButton isValid={isValid} popupContent="Please&nbsp;create&nbsp;your&nbsp;account before&nbsp;checking&nbsp;out">Continue →</ContinueButton>
            )}
          </div>
        </form>
      </Modal.Content>
    </Modal>
  )
}

SignUpModal.defaultProps = {
  title: 'Create your account'
}

export default SignUpModal
