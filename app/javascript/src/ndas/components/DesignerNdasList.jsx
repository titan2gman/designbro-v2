import React from 'react'
import PropTypes from 'prop-types'

import Spinner from '@components/Spinner'

import DesignerNda from '@ndas/containers/DesignerNda'
import DesignerNdasPager from '@ndas/containers/DesignerNdasPager'

const containerClassName = (loading) => (
  loading ? 'flex align-center justify-center flex-grow'
    : 'container my-ndas__content'
)

const DesignerNdasList = ({ loading, designerNdas }) => (
  <main className="page-main flex direction-column">
    <div className="main-subheader">
      <div className="container">
        <h1 className="main-subheader__title">
          My NDA's
        </h1>
      </div>
    </div>

    <div className={containerClassName(loading)}>
      <Spinner loading={loading}>
        {() => (
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
        )}
      </Spinner>
    </div>
  </main>
)

DesignerNdasList.propTypes = {
  designerNdas: PropTypes.arrayOf(
    PropTypes.object.isRequired
  ).isRequired,

  loading: PropTypes.bool.isRequired
}

export default DesignerNdasList
