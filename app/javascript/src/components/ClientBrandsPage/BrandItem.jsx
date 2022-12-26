import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import { setBrandBackgroundColors } from '@utils/brandBackgroundColors'

const BrandItem = ({ brand, index }) => {
  return (
    <div className="col-md-4 col-sm-6 col-xs-12">
      <Link to={`/c/brands/${brand.id}/in-progress`}>
        <div className="brand-item">
          {!!brand.unread_count && (
            <div className="notification">
              {brand.unread}
            </div>
          )}

          <div
            className="brand-background"
            style={setBrandBackgroundColors(brand.logo, index)}
          >
            {!brand.logo && (
              <h2>
                {brand.name}
              </h2>
            )}
          </div>

          <div className="brand-details">
            <div className="brand-header">
              <h3>
                {brand.name}
              </h3>

              {brand.hasNda && (
                <div className="private icon icon-eye-crossed" />
              )}
            </div>

            <div className="brand-stats">
              <div className="in-progress">
                <span className="dot" />
                {brand.projectsInProgressCount} in progress
              </div>

              <div className="completed">
                <span className="dot" />
                {brand.projectsCompletedCount} completed
              </div>

              <div className="files">
                <span className="dot" />
                {brand.filesCount} files
              </div>
            </div>
          </div>
        </div>
      </Link>
    </div>
  )
}

BrandItem.propTypes = {
  brand: PropTypes.object.isRequired
}

export default BrandItem
