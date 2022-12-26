import React from 'react'
import classNames from 'classnames'
import Button from '@components/Button'
import BrandSwitcher from '../../../BrandSwitcher'
import styles from './Header.module.scss'

const ProductsListHeader = ({ isRequestManualVisible, brandName, showGetQuoteModal }) => (
  <div className="row">
    <div className="col-md-8 col-sm-6 col-xs-12">
      <div className={styles.subheaderWrapper}>
        <h1 className="bfs-subheader__title main-subheader__title">
          Select project type for<br/><span className="brand-name">{brandName}</span>
          <BrandSwitcher />
        </h1>
      </div>
    </div>

    {isRequestManualVisible && (
      <div className="col-md-4 col-sm-6 col-xs-12">
        <div className={styles.manualTile}>
          Looking for something else or want to change your existing design?

          <Button className={styles.button} onClick={showGetQuoteModal}>
            Let us know
          </Button>
        </div>
      </div>
    )}
  </div>
)

export default ProductsListHeader
