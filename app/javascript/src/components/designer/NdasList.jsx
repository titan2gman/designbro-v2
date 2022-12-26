import React from 'react'
import PropTypes from 'prop-types'

import DesignerNda from '@ndas/containers/DesignerNda'
import DesignerNdasPager from '@ndas/containers/DesignerNdasPager'

const containerClassName = (inProgress) => (
  inProgress ? 'flex align-center justify-center flex-grow'
    : 'container my-ndas__content'
)

const DesignerNdasList = ({ inProgress, designerNdas }) => (
  <main className="page-main flex direction-column">
    <div className="main-subheader">
      <div className="container">
        <h1 className="main-subheader__title">
          My NDA's
        </h1>
      </div>
    </div>

    <div className={containerClassName(inProgress)}>
      <div>
        <div className="my-ndas-items">
          {designerNdas.map((designerNda, index) => (
            <DesignerNda key={index} designerNda={designerNda} />
          ))}
        </div>

        <div className="text-center">
          <DesignerNdasPager />
        </div>
      </div>
    </div>
  </main>
)

DesignerNdasList.propTypes = {
  designerNdas: PropTypes.arrayOf(
    PropTypes.object.isRequired
  ).isRequired,

  inProgress: PropTypes.bool.isRequired
}

export default DesignerNdasList
