import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { history } from '../../../history'

import FormButton from '@components/FormButton'
import styles from './BackButton.module.scss'

const BackButton = ({ onClick, className }) => (
  <div className={classNames(styles.wrapper, className)}>
    <FormButton onClick={onClick || history.goBack}>
      Back
    </FormButton>
  </div>
)

export default BackButton
