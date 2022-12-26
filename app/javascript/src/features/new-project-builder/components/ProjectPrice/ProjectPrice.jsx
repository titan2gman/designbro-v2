import React from 'react'
import { useSelector } from 'react-redux'
import Dinero from 'dinero.js'

import { productSelector } from '../../selectors/products'

import styles from './ProjectPrice.module.scss'

const Price = () => {
  const product = useSelector(productSelector)

  if (!product.price) {
    return null
  }

  return (
    <div className={styles.priceWrapper}>
      Project price
      <div className={styles.price}>
        {Dinero({ amount: product.price.cents }).toFormat('$0,0')}
      </div>
    </div>
  )
}

export default Price
