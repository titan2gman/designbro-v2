import React from 'react'
import PropTypes from 'prop-types'
import ProductItem from './ProductItemContainer'

const ProductsList = ({ products, isRequestManualVisible }) => (
  <main className="products-list">
    <div className="row">
      {products.map((product) => {
        return (
          <ProductItem
            key={product.key}
            product={product}
          />
        )
      })}

      {isRequestManualVisible && (
        <ProductItem
          product={{
            id: 'manual',
            key: 'manual',
            name: 'Other Design',
            description: 'Looking for something else or want to change your existing design? Let us know.'
          }}
        />
      )}
    </div>
  </main>
)

ProductsList.propTypes = {
  products: PropTypes.array.isRequired
}

export default ProductsList
