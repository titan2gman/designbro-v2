import React from 'react'
import { useSelector } from 'react-redux'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import { hostName } from '@constants'
import { isAuthenticatedSelector } from '@selectors/me'

import styles from './Logo.module.scss'

const Logo = () => {
  const isAuthenticated = useSelector(isAuthenticatedSelector)

  return (
    isAuthenticated ? (
      <Link to="/" className={styles.logo} />
    ) : (
      <a href={hostName} className={styles.logo} />
    )
  )
}

export default Logo
