import React from 'react'
import classNames from 'classnames'
import moment from 'moment'
import { Dropdown } from 'semantic-ui-react'
import { Link } from 'react-router-dom'
import Pager from '@designer/containers/DesignerEarningPager'
import DesignerEarningsHeader from './EarningsHeader'

const options = [
  { text: 'All My Earnings', value: 'all' },
  { text: 'Payouts', value: 'payouts' }
]

const TableRowItemEarn = ({ earning, className }) => (
  <div className={classNames('table-row-item', className)}>
    <div className="table-row-item__cell">
      <p className="table-row-item__cell-date">
        {moment(earning.createdAt).format('DD.MM.YYYY')}
      </p>
    </div>
    <div className="table-row-item__cell table-row-item__info">
      <div className="table-row-item__info-block table-row-item__description">
        <Link to={`/d/projects/${earning.projectId}`} className="table-row-item__text table-row-item__text-link text-underline">
          {earning.projectName}
        </Link>
      </div>
      <div className="table-row-item__info-block">
        <p className="in-green-500 font-bold">
          $ {earning.amount}
        </p>
      </div>
    </div>
  </div>
)

export default ({ earnings, me, payoutMinAmount }) => (
  <main>
    <DesignerEarningsHeader me={me} payoutMinAmount={payoutMinAmount} />
    <div className="container earn__content">
      <div className="earn__tabs-titles hidden-sm-down">
        <a className="earn__tab-title main-body__title main-body__tab-title main-body__tab-title--active cursor-pointer">
          All My Earnings
          <span className="main-body__tab-line" />
        </a>
        <Link className="earn__tab-title main-body__title main-body__tab-title" to="/d/payouts">
          Payouts
          <span className="main-body__tab-line" />
        </Link>
      </div>
      <Dropdown className="main-dropdown hidden-md-up" fluid selection options={options} />
      <div>
        <div className="my-earn-items">
          { earnings.map((earning) => (
            <TableRowItemEarn
              key={earning.id}
              earning={earning}
            />
          ))}
        </div>
        <div className="text-center">
          <Pager className="inline-block" />
        </div>
      </div>
    </div>
  </main>
)
