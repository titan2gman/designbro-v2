import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const NewBrand = ({ isSelected, onSelect }) => (
  <div className="brand-item-wrapper">
    <div
      className={classNames('brand-item', 'new-brand', { selected: isSelected })}
      onClick={onSelect}
    >
      {isSelected && (
        <div className="tick"/>
      )}

      <div className="plus">+</div>
      <div className="new-brand-label">New brand</div>
    </div>

    <div className="brand-name">
      New brand
    </div>
  </div>
)

NewBrand.propTypes = {
  isSelected: PropTypes.bool,
  onSelect: PropTypes.func.isRequired
}

export default NewBrand
