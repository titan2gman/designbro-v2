import _ from 'lodash'

export const validateProductStep = (state) => {
  const validation = {}

  if (!state.newProject.stepProductAttributes.productId) {
    validation.productId = 'Product is required'
  }

  return validation
}

export const isProductStepValid = (validation) => {
  const attributes = [
    'productId'
  ]

  return _.every(_.pick(validation, attributes), _.isEmpty)
}
