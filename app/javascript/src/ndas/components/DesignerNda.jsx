import React, { Component } from 'react'
import moment from 'moment'

import DesignerNdaModal from '@ndas/components/DesignerNdaModal'

export default class extends Component {
  state = {
    isOpened: false
  }

  open = () => this.setState({ isOpened: true })
  close = () => this.setState({ isOpened: false })

  render () {
    const { isOpened } = this.state

    const { designerNda, brand, nda, company } = this.props

    return (
      <div className="table-row-item">
        <div className="table-row-item__cell">
          <p className="table-row-item__cell-date">
            {moment(designerNda.createdAt).format('DD.MM.YYYY')}
          </p>
        </div>

        <div className="table-row-item__cell table-row-item__info">
          <div className="table-row-item__info-block table-row-item__name">
            <p className="table-row-item__text">
              {company.companyName}
            </p>
          </div>

          <div className="table-row-item__info-block my-ndas__order-last">
            <div className="cursor-pointer table-row-item__text-link table-row-item__status" onClick={this.open}>
              <span className="table-row-item__text hidden-sm-down">
                View
              </span>

              <i className="icon icon-eye table-row-item__icon" />
            </div>
          </div>

          <div className="table-row-item__info-block table-row-item__description">
            <DesignerNdaModal
              open={this.open}
              close={this.close}
              isOpened={isOpened}

              nda={nda}
              brand={brand}
            />
          </div>
        </div>
      </div>
    )
  }
}
