import React, { Component } from 'react'
import { compose } from 'redux'
import { connect } from 'react-redux'
import { actions } from 'react-redux-form'
import { withRouter } from 'react-router-dom'

import camelCase from 'lodash/camelCase'
import mergeWith from 'lodash/mergeWith'

import { saveStep } from '@actions/projectBuilder'
import { withSpinner } from '@components/withSpinner'

import { getProject } from '@reducers/projects'

import clearForm from '@utils/clearForm'
import emptyCustomizer from '@utils/emptyCustomizer'

import { updateProjectPackagingType } from '@actions/newProject'
import { getProjectBuilderStep } from '@selectors/projectBuilder'

import PackagingType from './PackagingType'

class PackagingTypeContainer extends Component {
  componentWillMount () {
    this.props.onComponentWillMount()
  }

  onFormChange = () => {
    const { openStep, saveStep } = this.props
    saveStep(openStep)
  }

  onPackagingTypeChange = (model, value) => (dispatch) => {
    dispatch(actions.change(model, value))

    this.onFormChange()
  }

  render () {
    return (<PackagingType
      {...this.props}
      onFormChange={this.onFormChange}
      onPackagingTypeChange={this.onPackagingTypeChange}
    />)
  }
}

const getPackagingType = (state) => (
  state.forms.newProjectPackagingType.packagingType
)

const getCanPackagingTypeMeasurements = (state) => (
  state.forms.newProjectPackagingType.canMeasurements
)

const getLabelPackagingTypeMeasurements = (state) => (
  state.forms.newProjectPackagingType.labelMeasurements
)

const getBottlePackagingTypeMeasurements = (state) => (
  state.forms.newProjectPackagingType.bottleMeasurements
)

const getCardBoxPackagingTypeMeasurements = (state) => (
  state.forms.newProjectPackagingType.cardBoxMeasurements
)

const getPouchPackagingTypeMeasurements = (state) => (
  state.forms.newProjectPackagingType.pouchMeasurements
)

const getPlasticPackPackagingTypeMeasurements = (state) => (
  state.forms.newProjectPackagingType.plasticPackMeasurements
)

const getPackagingTypeMeasurements = (state) => {
  const packagingType = getPackagingType(state)

  switch (packagingType) {
  case 'can':
    return getCanPackagingTypeMeasurements(state)
  case 'label':
    return getLabelPackagingTypeMeasurements(state)
  case 'bottle':
    return getBottlePackagingTypeMeasurements(state)
  case 'card_box':
    return getCardBoxPackagingTypeMeasurements(state)
  case 'pouch':
    return getPouchPackagingTypeMeasurements(state)
  case 'plastic_pack':
    return getPlasticPackPackagingTypeMeasurements(state)
  default:
    return {}
  }
}

const getPackagingFinalForm = (state, serverParams) => {
  const packagingFinalForm = state.forms.newProjectPackagingType

  mergeWith(packagingFinalForm, serverParams, emptyCustomizer)

  return packagingFinalForm
}

const onComponentWillMount = () => (dispatch, getState) => {
  dispatch(actions.reset('forms.newProjectPackagingType'))

  const { id: projectId, packagingType, packagingMeasurements } = getProject(getState())

  if (packagingType) {
    const measurementsKey = `${camelCase(packagingType)}Measurements`
    const serverParams = { packagingType, [measurementsKey]: packagingMeasurements }
    const packagingFinalForm = getPackagingFinalForm(getState(), serverParams)

    dispatch(actions.merge('forms.newProjectPackagingType', packagingFinalForm))
  }
}

const mapStateToProps = (state, props) => {
  const stepName = props.match.params.step
  const openStep = getProjectBuilderStep(state, stepName)

  return {
    openStep,
    selectedPackagingType: state.forms.newProjectPackagingType.packagingType,
    inProgress: state.newProject.inProgress
  }
}

export default compose(
  withRouter,
  connect(mapStateToProps, {
    onComponentWillMount,
    saveStep
  }),
  withSpinner,
  clearForm('forms.newProjectPackagingType')
)(PackagingTypeContainer)
