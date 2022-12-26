import React from 'react'
import { useSelector } from 'react-redux'
import { Popup } from 'semantic-ui-react'
import classNames from 'classnames'

import Button from '../../Button'

import styles from './ContinueButton.module.scss'

const inProgressSelector = (state) => state.newProjectBuilder.createInProgress || state.newProjectBuilder.updateInProgress

const ContinueButton = ({ isValid, validate, children, popupContent, className }) => {
  const inProgress = useSelector(inProgressSelector)

  return isValid ? (
    <Button className={classNames(styles.continueBtn, className)} waiting={inProgress}>{children}</Button>
  ) : (
    <Popup
      trigger={<Button className={className} styledAsDisabled onClick={(e) => { e.preventDefault(); validate && validate() }}>{children}</Button>}
      content={popupContent}
      on="click"
      position="top center"
      className={styles.popup}
    />
  )
}

export default ContinueButton
