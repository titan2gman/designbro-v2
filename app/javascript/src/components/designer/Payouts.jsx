import React from 'react'
import classNames from 'classnames'
import moment from 'moment'
import { Dropdown } from 'semantic-ui-react'
import { Link } from 'react-router-dom'
import DesignerPayoutsPager from '@designer/containers/DesignerPayoutsPager'
import DesignerEarningsHeader from './EarningsHeader'

import { humanizePayoutState } from '@utils/humanizer'

const options = [
  { text: 'All My Earnings', value: 'all' },
  { text: 'Payouts', value: 'payouts' }
]

const TableRowItemPayouts = ({ payout, className }) => (
  <div className={classNames('table-row-item', className)}>
    <div className="table-row-item__cell">
      <p className="table-row-item__cell-date">
        {moment(payout.createdAt).format('DD.MM.YYYY')}
      </p>
    </div>

    <div className="table-row-item__info-block flex-grow text-left">
      <span className="table-row-item__text">
        {humanizePayoutState(payout.payoutState)}
      </span>
    </div>

    <div className="table-row-item__cell table-row-item__info">
      <div className="table-row-item__info-block flex-grow text-right">
        <p className="in-green-500 font-bold">
          $ {payout.amount}
        </p>
      </div>
      {/* <div className='table-row-item__info-block'>
        <a href='#' className='table-row-item__text-link table-row-item__status hidden-sm-down'>
          <span className='table-row-item__text'>Download Receipt</span>
          <i className='icon-download table-row-item__icon' />
        </a>
      </div> */}
    </div>
  </div>
)

export default ({ payouts, me, payoutMinAmount }) => (
  <main>
    <DesignerEarningsHeader me={me} payoutMinAmount={payoutMinAmount} />
    <div className="container earn__content">
      <div className="earn__tabs-titles hidden-sm-down">
        <Link className="earn__tab-title main-body__title main-body__tab-title" to="/d/my-earnings">
          All My Earnings
          <span className="main-body__tab-line" />
        </Link>
        <a className="earn__tab-title main-body__title main-body__tab-title main-body__tab-title--active" href="#">
          Payouts
          <span className="main-body__tab-line" />
        </a>
      </div>
      <Dropdown className="main-dropdown hidden-md-up" fluid selection options={options} />
      <div>
        <div className="my-earn-items">
          {payouts.map((payout) => (
            <TableRowItemPayouts
              key={payout.id}
              payout={payout}
            />
          ))}
        </div>
        <div className="text-center">
          <DesignerPayoutsPager className="inline-block" />
        </div>
      </div>
    </div>
  </main>
)
