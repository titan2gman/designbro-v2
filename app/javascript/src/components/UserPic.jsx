import React from 'react'
import classNames from 'classnames'
import { Button } from 'semantic-ui-react'

const UserPic = ({ name, className, onClick }) => (
  <Button className={classNames('header__menu-btn main-userpic main-userpic-md', className)} onClick={onClick}>
    <span className="main-userpic__text-md">{name}</span>
  </Button>
)

export default UserPic
