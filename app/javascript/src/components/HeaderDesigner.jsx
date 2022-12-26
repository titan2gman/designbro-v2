import React from 'react'
import { Link } from 'react-router-dom'
import HeaderControlsDesigner from '@components/HeaderControlsDesigner'

const HeaderDesigner = ({ registration }) => (
  <header className="header-designer bg-black">
    <Link to="/" className="header-designer__logo"><img src="/logo_light.svg" alt="logo" /></Link>
    <HeaderControlsDesigner registration={registration} />
  </header>
)

export default HeaderDesigner
