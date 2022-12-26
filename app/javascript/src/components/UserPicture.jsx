import React from 'react'
import classNames from 'classnames'
import { Button } from 'semantic-ui-react'

import styles from './UserPicture.module.scss'

const UserPicture = ({ name }) => (
  <Button className={styles.userPicture}>
    <span className={styles.userName}>{name}</span>
  </Button>
)

export default UserPicture
