import React from 'react'
import dinero from 'dinero.js'
import classNames from 'classnames'

//styles
import styles from './Price.module.scss'

const Price = ({ price, isFree, isFreeUpgrade, isTotal }) => {
  return (
    <div className={styles.priceWrapper}>
      {isFreeUpgrade ? (
        <span className={styles.free}>Free upgrade</span>
      ) : (
        <>
          <span
            className={classNames(styles.price, {
              [styles.crossed]: isFree,
              [styles.total]: isTotal,
            })}
          >
            {price}
          </span>
          {isFree && (
            <span
              className={classNames(styles.free, { [styles.total]: isTotal })}
            >
              Free
            </span>
          )}
        </>
      )}
    </div>
  )
}

export default Price
