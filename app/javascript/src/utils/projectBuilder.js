import _ from 'lodash'

export const examplesStep = { componentName: 'Examples' }
export const detailsStep = { componentName: 'Details' }
export const checkoutStep = { componentName: 'Checkout' }
export const packagingTypeStep = { componentName: 'PackagingType' }
export const colorsQuestion = { componentName: 'ColorsPicker' }
export const competitorsQuestion = { componentName: 'Competitors' }
export const existingDesignsQuestion = { componentName: 'ExistingDesigns' }
export const existingLogosQuestion = { componentName: 'ExistingLogos' }
export const inspirationsQuestion = { componentName: 'Inspirations' }
export const additionalDocumentsQuestion = { componentName: 'AdditionalDocuments' }
export const stockImagesQuestion = { componentName: 'StockImages' }
export const brandSelectorQuestion = { componentName: 'BrandSelector' }
export const optionalBrandSelectorQuestion = { componentName: 'OptionalBrandSelector' }

export const stepHasQuestion = (questions, question) => {
  return _.some(questions, question)
}

export const getStepQuestions = (questions, step) => {
  return _.filter(questions, { projectBuilderStepId: step.id })
}

export const getStepAttributeNames = (questions, step) => {
  return _.map(questions, (question) => _.camelCase(question.attributeName)).filter(Boolean)
}
