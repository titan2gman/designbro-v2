import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import { Button, Popup } from 'semantic-ui-react'

import { staticHost } from '@utils/hosts'

import HeaderControls from '@components/HeaderControls'
import HeaderControlsClient from '@components/HeaderControlsClient'
import HeaderControlsDesigner from '@components/HeaderControlsDesigner'

const Controls = ({ userType }) => {
  switch (userType) {
  case 'designer':
    return <HeaderControlsDesigner />
  case 'client':
    return <HeaderControlsClient />
  default:
    return <HeaderControls />
  }
}

class MobileMenu extends React.Component {
  state = { isOpen: false }

  handleOpen = () => {
    this.setState({ isOpen: true })
  }

  handleClose = () => {
    this.setState({ isOpen: false })
  }

  render () {
    return (
      <Popup
        trigger={<Button className="main-header__menu-btn in-white"><i className="icon-menu" /></Button>}
        content={
          <div className="header-mobile__dropdown bg-green-500 in-white hidden-sm-up">
            <div className="modal__actions--top">
              <div className="modal-close in-white">
                <i className="icon-cross" onClick={this.handleClose} />
              </div>
            </div>

            <ul className="header-mobile__menu">
              <li>
                <a href={`${staticHost}/design-project-types`} className="header-mobile__menu-link">
                  Start a Project
                </a>
              </li>

              <li>
                <Link to="/login" className="header-mobile__menu-link">Login</Link>
              </li>
            </ul>
          </div>
        }
        onClose={this.handleClose}
        onOpen={this.handleOpen}
        open={this.state.isOpen}
        positioning="top left"
        on="click"
      />
    )
  }
}

const HeaderDark = ({ userType }) => (
  <header className="main-header bg-black">
    <div className="hidden-sm-up">
      <MobileMenu />
    </div>
    {userType
      ? <Link to="/" className="main-header__logo"><img src="/logo_light.svg" alt="logo" /></Link>
      : <a href={staticHost} className="main-header__logo"><img src="/logo_light.svg" alt="logo" /></a>
    }
    <Controls userType={userType} />
  </header>
)

HeaderDark.propTypes = {
  userType: PropTypes.string.isRequired
}

export default HeaderDark
