import React from 'react'
import { productsWithPdfDeliverable } from '@constants'

const DesignerDeliverables = ({ products, showDeliverablesModal }) => {
  return (
    <main className="page-main flex direction-column">
      <div className="main-subheader designer-deliverables">
        <div className="left-panel">
          <h1 className="main-subheader__title m-b-0">
            Deliverables
          </h1>
          <h5 className="main-subheader__subtitle">
            Guide
          </h5>
          <p className="designer-deliverables__description">
            This help tool shows deliverables of every project and indicates how we
            at DesignBro would like to see you upload the final files of projects you won.
            To continue select your project type below.
          </p>
        </div>
        <div className="right-panel hidden-sm-down">
        </div>
      </div>

      <div className="divider-line"/>

      <div className="designer-deliverable__list row">
        {products.map((chunk, i) => (
          <div className="col-xs-12 col-sm-4" key={i}>
            {chunk.map((product) => (
              <div key={product.id} className="designer-deliverable__list-item">
                {productsWithPdfDeliverable.includes(product.key) ? (
                  <a
                    className="designer-deliverable__list-item--active"
                    onClick={() => showDeliverablesModal({ productKey: product.key })}
                  >
                    {product.name}
                  </a>
                ) : (
                  <a className="main-button-link--disabled">
                    {product.name}
                  </a>
                )}
              </div>
            ))}
          </div>
        ))}
      </div>
    </main>
  )
}

export default DesignerDeliverables
