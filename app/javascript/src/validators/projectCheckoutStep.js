import _ from 'lodash'

export const validateCheckout = (state) => {
  const validation = {}

  if (!state.newProject.stepCheckoutAttributes.firstName) {
    validation.firstName = 'Required'
  }

  if (!state.newProject.stepCheckoutAttributes.lastName) {
    validation.lastName = 'Required'
  }

  if (!state.newProject.stepCheckoutAttributes.countryCode) {
    validation.countryCode = 'Required'
  }

  return validation
}

export const isCheckoutValid = (validation) => {
  const attributes = [
    'firstName',
    'lastName',
    'countryCode'
  ]

  return _.every(_.pick(validation, attributes), _.isEmpty)
}
