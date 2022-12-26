import React from 'react'

import Logo from './Logo'
import ProgressBar from './ProgressBar'
import ClientProfile from './ClientProfile'

import styles from './Header.module.scss'

const Header = () => {
  return (
    <header className={styles.header}>
      <div className={styles.logoWrapper}>
        <Logo />
      </div>
      <div className={styles.progressBarWrapper}>
        <ProgressBar />
      </div>
      <div className={styles.clientProfileWrapper}>
        <ClientProfile />
      </div>
    </header>
  )
}

export default Header
