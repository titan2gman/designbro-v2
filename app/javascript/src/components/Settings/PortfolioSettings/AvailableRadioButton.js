import React, { Component } from 'react'
import { connect } from 'react-redux'
import classNames from 'classnames'
import Popover from '@terebentina/react-popover'
import styles from './PortfolioSettings.module.scss'

import {
  changeProfileAttribute,
  savePortfolioSettings
} from '@actions/designer'

class AvailableRadioButton extends Component {
  handleChange = () => {
    const { name, value, changeProfileAttribute, savePortfolioSettings } = this.props

    changeProfileAttribute(name, !value)
    savePortfolioSettings()
  }

  render () {
    return (
      <div className={styles.tickWrapper} onClick={this.handleChange}>
        <div className={classNames(styles.tick, { [styles.selected]: this.props.value })} />
        <div>
          I'm available for 1 on 1 projects
          <Popover trigger={<i className="icon-info-circle" />} position="right">
            <p><strong>Availability for 1 on 1 project</strong></p>
            <p>If you've selected that you are available to work on 1 on 1 projects, your portfolio page will automatically be shown to potential clients.</p>
            <p>If you've selected that you are <strong>not</strong> available to work on 1 on 1 projects, your portfolio page will not be shown.</p>
          </Popover>
        </div>
      </div>
    )
  }
}

export default connect(null, {
  changeProfileAttribute,
  savePortfolioSettings
})(AvailableRadioButton)
