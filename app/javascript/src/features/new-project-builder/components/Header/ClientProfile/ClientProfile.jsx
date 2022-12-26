import React from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { Link } from 'react-router-dom'
import Popover from '@terebentina/react-popover'

import { isAuthenticatedSelector, myNameOrEmailSelector } from '@selectors/me'
import { showSignInModal, hideModal } from '@actions/modal'
import SignoutButton from '@containers/SignoutButton'

import styles from './ClientProfile.module.scss'


const ClientProfile = () => {
  const dispatch = useDispatch()

  const handleSignInClick = () => {
    dispatch(showSignInModal({ successCallback: () => dispatch(hideModal()) }))
  }

  const isAuthenticated = useSelector(isAuthenticatedSelector)
  const clientName = useSelector(myNameOrEmailSelector)

  return isAuthenticated ? (
    <Popover
      className={styles.test}
      trigger={
        <div className={styles.clientProfileWrapper}>
          <span className={styles.clientName}>{clientName}</span>
          <div className={styles.avatar}></div>
        </div>
      }
      position="bottom"
    >
      <ul className="header-designer__dropdown header__menu-dropdown header-dropdown__trigon">
        <li className="header__menu-dropdown-item">
          <Link to="/c" className="header__menu-dropdown-link">
            My Brands
          </Link>
        </li>

        <li className="header__menu-dropdown-item">
          <Link to="/c/settings" className="header__menu-dropdown-link">
            Account Settings
          </Link>
        </li>

        <li className="header__menu-dropdown-item">
          <Link to="/c/settings/payment" className="header__menu-dropdown-link">
            Payment Settings
          </Link>
        </li>

        <li className="header__menu-dropdown-item">
          <Link to="/c/transactions" className="header__menu-dropdown-link">
            Transactions
          </Link>
        </li>

        <li className="header__menu-dropdown-item">
          <SignoutButton />
        </li>
      </ul>
    </Popover>
  ) : (
    <span onClick={handleSignInClick} className={styles.clientName}>Login</span>
  )
}

export default ClientProfile
