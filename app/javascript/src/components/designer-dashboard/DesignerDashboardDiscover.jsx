import _ from 'lodash'
import React from 'react'
import PropTypes from 'prop-types'
import { Link, NavLink } from 'react-router-dom'

import { appendKey } from '@utils/dropdowns'

import Spinner from '@components/Spinner'
import Dropdown from '@components/inputs/Dropdown'

import NavigationDropdown from '@containers/NavigationDropdown'
import DesignerProjectCard from './DesignerProjectCard'
import DesignerStatsPanel from '@designer/containers/DesignerStatsPanel'
import DesignerProjectsPager from '@designer/containers/DesignerProjectsPager'

const stateFilterOptions = [
  { text: 'All', value: 'all' },
  { text: 'With free spots', value: 'with free spots' },
  { text: 'Without free spots', value: 'without free spots' }
].map(appendKey)

const prizeFilterOptions = [
  { text: 'Popular first', value: 'popular first' },
  { text: 'New first', value: 'new first' },
  { text: 'Prize low-high', value: 'prize low-high' },
  { text: 'Prize high-low', value: 'prize high-low' },
  { text: 'Default', value: 'default' }
].map(appendKey)

const DashboardTopNav = () => (
  <div>
    <Link className="designer-dashboard__tab-title main-body__title main-body__tab-title" to="/d">My Projects</Link>
    <Link className="designer-dashboard__tab-title main-body__title main-body__tab-title main-body__tab-title--active" to="/d/discover">Discover Projects</Link>
  </div>
)

const DashboardFilters = ({
  productCategories,
  onInputChange,
  onSearchSubmit,
  onStateDropdownChange,
  onPrizeDropdownChange,
  stateDropdownValue,
  prizeDropdownValue,
  inputValue,
  onNavClick
}) => (
  <div className="designer-dashboard__filters">
    <div onClick={onNavClick}>
      <NavLink exact to="/d/discover/" className="designer-dashboard__filter content-filter" activeClassName="content-filter--active">All</NavLink>

      {_.map(productCategories, (category) => {
        return (
          <NavLink
            to={`/d/discover/${category.id}`}
            className="designer-dashboard__filter content-filter"
            activeClassName="content-filter--active"
          >
            {category.name}
          </NavLink>
        )
      })}
    </div>

    <div className="designer-dashboard__secondary hidden-md-down">
      <Dropdown
        id="prize-filter"
        className="main-dropdown main-dropdown-sm inline-block m-r-30"
        fluid
        selection
        options={prizeFilterOptions}
        onChange={onPrizeDropdownChange}
        value={prizeDropdownValue}
      />
      <Dropdown
        id="state-filter"
        className="main-dropdown main-dropdown-sm inline-block m-r-30"
        fluid
        selection
        options={stateFilterOptions}
        onChange={onStateDropdownChange}
        value={stateDropdownValue}
      />
      <label className="designer-dashboard__search-field search-field">
        <form onSubmit={onSearchSubmit}>
          <input
            name="search"
            id="search"
            type="text"
            className="search-field__input"
            onChange={onInputChange}
            value={inputValue}
          />
        </form>
        <i className="search-field__icon icon-search" />
      </label>
    </div>
  </div>
)

const BlankState = ({ src, text }) => (
  <div className="col-xs-12 col-md-6 offset-md-3">
    <div className="blank-state">
      <img className="blank-state__img" src={src} srcSet={`${src} 2x`} alt="" />
      <p className="blank-state__text">
        {text}
      </p>
    </div>
  </div>
)

const ContentWrapper = ({ children }) => (
  <div className="flex-grow">
    <div className="container">
      <div className="designer-dashboard__content">
        {children}
      </div>
    </div>
  </div>
)

const ProjectsView = ({ brands, projects, me, showModal, createDesignerNda }) => (
  <div>
    {projects.map((project, i) => (
      <DesignerProjectCard
        key={i}
        project={project}
        className="designer-dashboard__card"
        showModal={showModal}
        createDesignerNda={createDesignerNda}
      />
    ))}

    {!projects.length &&
      <BlankState src="/no_results_illustration_1x.jpg" text="No results" />
    }
  </div>
)

const DesignerDashboardDiscover = ({
  loading,
  type,
  brands,
  projects,
  productCategories,
  inputValue,
  isApproved,
  prizeFilter,
  stateFilter,
  stateDropdownValue,
  prizeDropdownValue,

  showModal,
  createDesignerNda,

  onNavClick,
  onInputChange,
  onSearchSubmit,
  onStateDropdownChange,
  onPrizeDropdownChange
}) => (
  <main className="designer-dashboard">
    <ContentWrapper>
      <div className="row">
        <div className="col-xs-12">
          <DashboardTopNav />
          <DashboardFilters
            productCategories={productCategories}
            onInputChange={onInputChange}
            onSearchSubmit={onSearchSubmit}
            onPrizeDropdownChange={onPrizeDropdownChange}
            onStateDropdownChange={onStateDropdownChange}
            stateDropdownValue={stateDropdownValue}
            prizeDropdownValue={prizeDropdownValue}
            inputValue={inputValue}
            onNavClick={onNavClick}
          />
        </div>
      </div>
      <div className="flex-grow">
        <div className="container">
          <div className="row">
            <div className="designer-dashboard__content col-xs-12">
              <Spinner loading={loading}>
                {isApproved ? (
                  <ProjectsView
                    brands={brands}
                    projects={projects}
                    showModal={showModal}
                    createDesignerNda={createDesignerNda}
                  />
                ) : (
                  <BlankState
                    src="/portfolio_not_approved_illustration_2Х.jpg"
                    text="Your portfolio has not yet been approved"
                  />
                )}
              </Spinner>
              <div className="text-center">
                <DesignerProjectsPager
                  type={type}
                  prizeFilter={prizeFilter}
                  stateFilter={stateFilter}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </ContentWrapper>
    <DesignerStatsPanel />
  </main>
)

DesignerDashboardDiscover.propTypes = {
  projects: PropTypes.arrayOf(PropTypes.object).isRequired,
  type: PropTypes.string,
  inputValue: PropTypes.string.isRequired,
  isApproved: PropTypes.bool.isRequired,
  prizeFilter: PropTypes.string.isRequired,
  stateFilter: PropTypes.string.isRequired,
  stateDropdownValue: PropTypes.string.isRequired,
  prizeDropdownValue: PropTypes.string.isRequired,

  onNavClick: PropTypes.func.isRequired,
  onInputChange: PropTypes.func.isRequired,
  onSearchSubmit: PropTypes.func.isRequired,
  onStateDropdownChange: PropTypes.func.isRequired,
  onPrizeDropdownChange: PropTypes.func.isRequired
}

export default DesignerDashboardDiscover
