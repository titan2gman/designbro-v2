import React from 'react'
import PropTypes from 'prop-types'
import { Link, withRouter } from 'react-router-dom'
import Popover from '@terebentina/react-popover'

import { staticHost } from '@utils/hosts'
import includesByRegex from '@utils/includesByRegex'

import SignoutButton from '@containers/SignoutButton'
import CurrentUserPic from '@containers/CurrentUserPic'

const DropdownMenu = ({ registration }) => (
  <Popover trigger={<CurrentUserPic />} position="bottom">
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
)

DropdownMenu.propTypes = {
  registration: PropTypes.bool
}

const HeaderControlsClient = ({ registration }) => {
  return (
    <div className="header-designer__controls">
      <div className="relative">
        <DropdownMenu registration={registration} />
      </div>
    </div>
  )
}

HeaderControlsClient.propTypes = {
  registration: PropTypes.bool
}

export default withRouter(HeaderControlsClient)
