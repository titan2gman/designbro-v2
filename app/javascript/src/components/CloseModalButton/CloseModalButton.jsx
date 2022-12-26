import React from 'react'
import classNames from 'classnames'

import styles from './CloseModalButton.module.scss'

const CloseModalButton = ({ onClose }) => <div className={classNames('icon-cross', styles.closeIcon)} onClick={onClose} />

export default CloseModalButton
