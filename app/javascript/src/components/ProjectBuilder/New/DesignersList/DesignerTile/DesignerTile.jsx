import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import moment from 'moment'
import styles from './DesignerTile.module.scss'

const DesignerTile = ({ winner, isSelected, onSelect }) => (
  <div className="col-md-4 col-sm-6 col-xs-12">
    <div
      className={classNames(styles.designerItem, { selected: isSelected })}
      onClick={onSelect}
    >
      {isSelected && (
        <div className={styles.tick} />
      )}

      <div className={styles.avatar}>
      </div>
      <div className={styles.content}>
        <div className={styles.designerName}>
          {winner.displayName}
        </div>

        <div className={styles.projectName}>
          {winner.brandName} - {winner.productName}
        </div>

        <div className={styles.date}>
          {winner.createdAt}
        </div>

        <div className={styles.projectName}>
          {winner.spotState}
        </div>
      </div>
    </div>
  </div>
)

DesignerTile.propTypes = {
  designer: PropTypes.object.isRequired,
  onSelect: PropTypes.func.isRequired,
  isSelected: PropTypes.bool
}

export default DesignerTile
