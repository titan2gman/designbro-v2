import React from 'react'
import SignoutButton from '@containers/SignoutButton'
import { Link } from 'react-router-dom'
import CurrentUserPic from '@containers/CurrentUserPic'
import Popover from '@terebentina/react-popover'

const DropdownMenu = ({ registration }) => (
  <Popover trigger={<CurrentUserPic />} position="bottom">
    <ul className="header-designer__dropdown header__menu-dropdown header-dropdown__trigon">
      {!registration &&
        <>
          <li className="header__menu-dropdown-item">
            <Link to="/d" className="header__menu-dropdown-link">Dashboard</Link>
          </li>
          <li className="header__menu-dropdown-item">
            <Link to="/d/settings" className="header__menu-dropdown-link">Account Settings</Link>
          </li>
          <li className="header__menu-dropdown-item">
            <Link to="/d/my-earnings" className="header__menu-dropdown-link">My Earnings</Link>
          </li>
          <li className="header__menu-dropdown-item">
            <Link to="/d/ndas" className="header__menu-dropdown-link">My NDA&prime;s</Link>
          </li>
          <li className="header__menu-dropdown-item">
            <Link to="/d/deliverables" className="header__menu-dropdown-link">Deliverables</Link>
          </li>
        </>
      }
      <li className="header__menu-dropdown-item">
        <SignoutButton />
      </li>
    </ul>
  </Popover>
)

export default ({ registration }) => (
  <div className="header-designer__controls">
    <div className="relative m-l-50">
      <DropdownMenu registration={registration} />
    </div>
  </div>
)
