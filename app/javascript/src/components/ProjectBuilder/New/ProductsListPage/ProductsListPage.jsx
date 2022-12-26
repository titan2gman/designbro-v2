import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import SubmitPanel from '../../SubmitPanel'
import Button from '@components/Button'
import ProductsListHeader from './Header'
import ProductsList from './ProductsListContainer'

const ProductsListPage = ({ canContinue, onBackButtonClick, onContinue }) => (
  <main className="product-step">
    <ProductsListHeader />

    <ProductsList />

    <SubmitPanel
      onBackButtonClick={onBackButtonClick}
    >
      <Button
        disabled={!canContinue}
        onClick={onContinue}
      >
        Continue
      </Button>
    </SubmitPanel>
  </main>
)

export default ProductsListPage
