import kebabCase from 'lodash/kebabCase'

import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const PackagingTypeItem = ({ label, isSelected, packagingType, onChange }) => (
  <div className="col-xs-6 col-md-3">
    <div className={classNames('psb-selected-box selected-box', { 'selected': isSelected })}>
      <div
        role="button"
        className="selected-box__content"
        onClick={() => onChange(packagingType)}
        id={`${kebabCase(packagingType)}-packaging-type`}>

        <div className="selected-box__icon-circle">
          <i className="icon-check in-white" />
        </div>

        <div className="font-13 in-white">
          {label}
        </div>
      </div>

      <img
        alt="selected-box"
        className="selected-box__image"
        src={`/${packagingType}_img.png`}
        srcSet={`/${packagingType}_img_2x.jpg 2x`}
      />
    </div>
  </div>
)

PackagingTypeItem.propTypes = {
  label: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  isSelected: PropTypes.bool.isRequired,
  packagingType: PropTypes.string.isRequired
}

export default PackagingTypeItem
