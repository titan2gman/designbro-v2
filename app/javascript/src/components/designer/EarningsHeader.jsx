import React from 'react'
import PropTypes from 'prop-types'

import ModalRequestPayout from '@designer/components/DesignerRequestPayoutModal'

const DesignerEarningsHeader = ({ me, payoutMinAmount }) => (
  <div className="main-subheader earn-subheader">
    <div className="container">
      <div className="main-subheader__content-flex">
        <h1 className="earn-subheader__title main-subheader__title">My Earnings</h1>
        <div className="earn-subheader__info">
          <div className="earn-subheader__info-block">
            <span className="main-subheader__info-title">All time earned</span>
            <p className="main-subheader__info-value">
              $ {me.allTimeEarned}
            </p>
          </div>
          <div className="earn-subheader__info-block">
            <span className="main-subheader__info-title">Available for payout</span>
            <p className="main-subheader__info-value in-green-500">
              $ {me.availableForPayout}
            </p>
          </div>
          <div className="earn-subheader__info-block">
            <ModalRequestPayout payoutMinAmount={payoutMinAmount} me={me} />
          </div>
        </div>
      </div>
    </div>
  </div>
)

DesignerEarningsHeader.propTypes = {
  me: PropTypes.object.isRequired,
  payoutMinAmount: PropTypes.object.isRequired
}

export default DesignerEarningsHeader
