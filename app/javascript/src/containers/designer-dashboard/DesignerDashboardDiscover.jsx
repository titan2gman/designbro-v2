import { connect } from 'react-redux'
import _ from 'lodash'
import React, { Component } from 'react'
import { withRouter } from 'react-router-dom'

import isNil from 'lodash/isNil'
import split from 'lodash/split'
import omitBy from 'lodash/omitBy'
import isEmpty from 'lodash/isEmpty'
import camelCase from 'lodash/camelCase'

import DesignerDashboardDiscover from '@components/designer-dashboard/DesignerDashboardDiscover'

import { showModal } from '@actions/modal'
import { createDesignerNda } from '@actions/designerNdas'
import {
  loadDiscoverProjects,
  resetPage,
  changeStateFilter,
  changeNameFilter,
  changePrizeFilter,
  resetNameFilter,
  resetStateFilter,
  resetPrizeFilter
} from '@actions/projects'

import { getCurrentNda, getNdasLoaded } from '@reducers/ndas'
import { isBrandIdentityApproved, isPackagingApproved, getMe } from '@reducers/me'
import { getPrize, getSpotState, getProjects, getStateFilter, getNameFilter, getProjectType, getPrizeFilter, getProjectsLoaded } from '@reducers/projects'
import { getProductCategoriesWithoutOther } from '@selectors/product'

class Container extends Component {
  componentWillReceiveProps (props) {
    if (this.props.productCategoryId !== props.productCategoryId) {
      this.props.resetPage()
      this.load(props)
    }
  }

  load ({ productCategoryId }) {
    const params = {
      product_category_id: productCategoryId
    }

    this.props.onLoad(omitBy(params, isNil))
  }

  handleInputChange (e) {
    if (!e.target) return
    this.props.changeNameFilter(e.target.value)
  }

  handleInputSubmit (e) {
    e.preventDefault()
    this.props.resetPage()
    this.props.loadDiscoverProjects({
      sort: getPrize(this.props.prizeFilter),
      name_cont: this.props.nameFilter,
      spots_state: getSpotState(this.props.stateFilter),
      product_category_id: this.props.productCategoryId
    })
  }

  handleStateDropdownChange (value) {
    this.props.changeStateFilter(value)
    this.props.resetPage()
    this.props.loadDiscoverProjects({
      sort: getPrize(this.props.prizeFilter),
      name_cont: this.props.nameFilter,
      spots_state: getSpotState(value),
      product_category_id: this.props.productCategoryId
    })
  }

  handlePrizeDropdownChange (value) {
    this.props.changePrizeFilter(value)
    this.props.resetPage()
    this.props.loadDiscoverProjects({
      sort: getPrize(value),
      name_cont: this.props.nameFilter,
      spots_state: getSpotState(this.props.stateFilter),
      product_category_id: this.props.productCategoryId
    })
  }

  handleNavClick () {
    this.props.resetNameFilter()
    this.props.resetStateFilter()
    this.props.resetPrizeFilter()
  }

  render () {
    const { stateFilter, nameFilter, prizeFilter } = this.props

    return (
      <DesignerDashboardDiscover
        {...this.props}
        inputValue={nameFilter}
        stateDropdownValue={stateFilter}
        prizeDropdownValue={prizeFilter}
        onNavClick={this.handleNavClick.bind(this)}
        onInputChange={this.handleInputChange.bind(this)}
        onSearchSubmit={this.handleInputSubmit.bind(this)}
        onStateDropdownChange={this.handleStateDropdownChange.bind(this)}
        onPrizeDropdownChange={this.handlePrizeDropdownChange.bind(this)}
      />
    )
  }
}

const mapStateToProps = (state, props) => {
  const productCategoryId = props.match.params.product_category_id
  const me = getMe(state)

  let experienceIsApproved

  if (productCategoryId) {
    experienceIsApproved = (_.find(me.experiences, (e) => {
      return e.product_category_id.toString() === productCategoryId
    }) || {}).state === 'approved'
  } else {
    experienceIsApproved = _.some(me.experiences, (e) => {
      return e.state === 'approved'
    })
  }

  return {
    productCategoryId,
    productCategories: getProductCategoriesWithoutOther(state),
    nda: getCurrentNda(state),
    brands: state.entities.brands,
    projects: getProjects(state),
    nameFilter: getNameFilter(state),
    ndaLoading: !getNdasLoaded(state),
    loading: !getProjectsLoaded(state),
    stateFilter: getStateFilter(state),
    prizeFilter: getPrizeFilter(state),
    isApproved: experienceIsApproved
  }
}

const mapDispatchToProps = {
  resetPage,
  resetNameFilter,
  resetStateFilter,
  resetPrizeFilter,
  onLoad: loadDiscoverProjects,
  loadDiscoverProjects,
  changeStateFilter,
  changePrizeFilter,
  changeNameFilter,
  showModal,
  createDesignerNda
}

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(Container))
