import _ from 'lodash'
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom'
import {
  saveStep
} from '@actions/projectBuilder'

import {
  changeEntityAttribute
} from '@actions/brandRelatedEntities'

import {
  getProjectBuilderStep,
  getProjectBuilderAttributes
} from '@selectors/projectBuilder'

import StarRating from './StarRating'

const mapStateToProps = (state, { match }) => {
  const stepName = match.params.step
  const openStep = getProjectBuilderStep(state, stepName)
  const attributes = getProjectBuilderAttributes(state)

  return {
    openStep,
    attributes
  }
}

const mergeProps = (stateProps, dispatchProps, ownProps) => {
  return {
    ...stateProps,
    ...dispatchProps,
    ...ownProps,
    value: _.get(stateProps.attributes, ownProps.name.split('.')),
    onChange: (v) => {
      const [entityName, index, name] = ownProps.name.split('.')
      dispatchProps.changeEntityAttribute(entityName, index, name, v)
      dispatchProps.saveStep(stateProps.openStep)
    }
  }
}

export default withRouter(
  connect(
    mapStateToProps, {
      changeEntityAttribute,
      saveStep
    }, mergeProps
  )(StarRating)
)
