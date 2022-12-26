import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import classNames from 'classnames'

const TotalSection = ({ total }) => (
  <section className="manage-panel__section manage-panel__section--balance">
    <h6 className="manage-panel__balance-title">Total Balance</h6>
    <div className="text-center">
      <Link className="manage-panel__balance-count" to="/d/my-earnings">
        <span className="align-middle">$</span>&nbsp;
        <span className="font-bold align-middle">{total}</span>
        <i className="manage-panel__caret icon-caret m-l-20" />
      </Link>
    </div>
  </section>
)

TotalSection.propTypes = {
  total: PropTypes.number.isRequired,
}

const CategoriesSection = () => (
  <section className="manage-panel__section manage-panel__section--cats"></section>
)
CategoriesSection.propTypes = {
  logoInProgressCount: PropTypes.number.isRequired,
  brandIdentityInProgressCount: PropTypes.number.isRequired,
  packagingInProgressCount: PropTypes.number.isRequired,
}

const StatsGroup = ({ children }) => (
  <ul className="manage-panel__stats">{children}</ul>
)

const StatsItem = ({ total, title, isExpired }) => (
  <li className="manage-panel__stat">
    <h4
      className={
        isExpired
          ? classNames('manage-panel__stat-title', {
            ['manage-panel__stat-title__orange']: parseInt(total) >= 20 && parseInt(total) < 35,
            ['manage-panel__stat-title__red']: parseInt(total) >= 35,
          })
          : 'manage-panel__stat-title'
      }
    >
      {total}
    </h4>
    <p className="manage-panel__cat-text">{title}</p>
  </li>
)
StatsItem.propTypes = {
  total: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
}

const StatsSection = ({
  expiredSpotsPercentage,
  inProgressCount,
  finalistsCount,
  winnersCount,
}) => (
  <section className="manage-panel__section manage-panel__section--stats">
    <StatsGroup>
      <StatsItem total={`${expiredSpotsPercentage}%`} title="Expired spots" isExpired={true} />
      <StatsItem total={inProgressCount} title="In progress" />
      <StatsItem total={finalistsCount} title="Finalists" />
      <StatsItem total={winnersCount} title="Winner" />
    </StatsGroup>
  </section>
)
StatsSection.propTypes = {
  inProgressCount: PropTypes.number.isRequired,
  finalistsCount: PropTypes.number.isRequired,
  winnersCount: PropTypes.number.isRequired,
}

const DesignerStatsPanel = ({
  className,
  total,
  categoriesStats,
  resultStats,
}) => (
  <div className={classNames('manage-panel', className)}>
    <TotalSection total={total} />
    <CategoriesSection />
    <StatsSection {...resultStats} />
  </div>
)

DesignerStatsPanel.propTypes = {
  className: PropTypes.string,
}

export default DesignerStatsPanel
