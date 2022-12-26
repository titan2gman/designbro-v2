import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const ProductItem = ({ product, isSelected, onSelect }) => (
  <div className="col-md-4 col-sm-6 col-xs-12 flex">
    <div
      className={classNames('product-item', { selected: isSelected })}
      onClick={onSelect}
    >
      {isSelected && (
        <div className="tick"/>
      )}

      <div className={classNames('product-logo', product.key)} />

      <div className="product-name">
        {product.name} design
      </div>

      <div className="product-description">
        {product.description}
      </div>

    </div>
  </div>
)

ProductItem.propTypes = {
  product: PropTypes.object.isRequired,
  onSelect: PropTypes.func.isRequired,
  isSelected: PropTypes.bool
}

export default ProductItem
