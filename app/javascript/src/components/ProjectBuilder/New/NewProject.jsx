import React, { useEffect } from 'react'
import queryString from 'query-string'

import ProductsListPage from './ProductsListPage'
import DesignersList from './DesignersList'

const InitialStep = ({ isProductsPageVisible, isDesignersPageVisible, onLoad }) => {
  useEffect(onLoad, [])

  if (isProductsPageVisible) {
    return <ProductsListPage />
  } else if (isDesignersPageVisible) {
    return <DesignersList />
  } else {
    return null
  }
}

export default InitialStep
