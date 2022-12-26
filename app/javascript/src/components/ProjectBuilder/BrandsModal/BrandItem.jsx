import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { setBrandBackgroundColors } from '@utils/brandBackgroundColors'

const BrandItem = ({ brand, isSelected, index, onSelect }) => (
  <div className="brand-item-wrapper">
    <div
      className={classNames('brand-item', { selected: isSelected })}
      style={setBrandBackgroundColors(brand.logo, index)}
      onClick={onSelect}
    >
      {isSelected && (
        <div className="tick"/>
      )}

      {!brand.logo && (
        <div className="brand-name">
          {brand.name}
        </div>
      )}
    </div>

    <div className="brand-name">
      {brand.name}
    </div>
  </div>
)

BrandItem.propTypes = {
  brand: PropTypes.object.isRequired,
  isSelected: PropTypes.bool
}

export default BrandItem
