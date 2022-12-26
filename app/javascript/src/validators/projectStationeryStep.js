import _ from 'lodash'

export const validateStationery = (state) => {
  const validation = {}

  if (!state.newProject.stepStationeryAttributes.compliment) {
    validation.compliment = 'Required'
  }

  if (!state.newProject.stepStationeryAttributes.letterHead) {
    validation.letterHead = 'Required'
  }

  if (!state.newProject.stepStationeryAttributes.backBusinessCardDetails) {
    validation.backBusinessCardDetails = 'Required'
  }

  if (!state.newProject.stepStationeryAttributes.frontBusinessCardDetails) {
    validation.frontBusinessCardDetails = 'Required'
  }

  return validation
}

export const isStationeryValid = (validation) => {
  const attributes = [
    'compliment',
    'letterHead',
    'backBusinessCardDetails',
    'frontBusinessCardDetails'
  ]

  return _.every(_.pick(validation, attributes), _.isEmpty)
}
