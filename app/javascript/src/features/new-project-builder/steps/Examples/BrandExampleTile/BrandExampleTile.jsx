import React from 'react'
import cn from 'classnames'

import styles from './BrandExampleTile.module.scss'

const BrandExampleTile = ({ example, isSelected, isDisabled, onClick, onDisabledClick }) => {
  const handleClick = () => {
    if (isDisabled) {
      onDisabledClick()
    } else {
      onClick(example.id)
    }
  }

  return (
    <div
      className={cn(
        styles.brandExampleTileWrapper, {
          [styles.selected]: isSelected,
        }
      )}
    >
      <div
        className={cn(styles.brandExampleTile, {
          [styles.disabled]: isDisabled
        })}
        style={{ backgroundImage: `url(${example.url})` }}
        onClick={handleClick}
      >
        {isSelected && (
          <div className={styles.tick} />
        )}
      </div>
    </div>
  )
}

export default BrandExampleTile
