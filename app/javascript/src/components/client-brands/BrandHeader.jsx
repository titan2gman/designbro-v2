import React, { Fragment } from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

import NavigationLinks from './NavigationLinks'

const BrandHeader = ({ brand }) => (
  <Fragment>
    {brand ? (
      <h1>
        {brand.hasNda && (
          <span className="private icon icon-eye-crossed" />
        )}

        {brand.name}

        <span className="brand-hint">
          &#9666;&nbsp;
          <Link
            to="/c"
            className="switch-brand"
          >
            switch brand
          </Link>
        </span>
      </h1>
    ) : (
      <h1>
        {/* god clent only */}

        Projects
      </h1>
    )}

    <NavigationLinks
      id={brand && brand.id}
    />
  </Fragment>
)

BrandHeader.propTypes = {
  brand: PropTypes.object.isRequired
}

export default BrandHeader
