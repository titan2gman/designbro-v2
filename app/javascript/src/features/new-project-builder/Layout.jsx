import React from 'react'
import Routes from './Routes'
import Header from './components/Header'

import styles from './Layout.module.scss'

const Layout = () => {
  return (
    <div className={styles.wrapper}>
      <Header />
      <Routes />
    </div>
  )
}

export default Layout
