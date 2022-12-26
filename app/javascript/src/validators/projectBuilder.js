import _ from 'lodash'
import { REQUIRED_GOOD_EXAMPLES_COUNT } from '@constants'
import {
  getProjectBuilderStepQuestions,
  getProjectBuilderAttributes
} from '@selectors/projectBuilder'

import {
  examplesStep,
  detailsStep,
  checkoutStep,
  packagingTypeStep,
  colorsQuestion,
  competitorsQuestion,
  existingDesignsQuestion,
  existingLogosQuestion,
  inspirationsQuestion,
  additionalDocumentsQuestion,
  stockImagesQuestion,
  brandSelectorQuestion,
  optionalBrandSelectorQuestion,

  stepHasQuestion,
  getStepQuestions,
} from '../utils/projectBuilder'

export const validateStep = (openStep, state) => {
  const validation = {}
  const questions = getProjectBuilderStepQuestions(state, openStep)
  const attributes = getProjectBuilderAttributes(state)

  _.forEach(questions, (question) => {
    if (question.validations) {
      const attrName = _.camelCase(question.attributeName)

      if (question.validations.includes('required') && !attributes[attrName]) {
        validation[attrName] = 'Required'
      }
    }
  })

  const hasBrandName = attributes.brandName || attributes.brandId && state.entities.brands[attributes.brandId].name

  if (stepHasQuestion(questions, brandSelectorQuestion) && !hasBrandName) {
    validation.brandName = 'Required'
  }

  if (stepHasQuestion(questions, optionalBrandSelectorQuestion) && attributes.brandExists === 'yes' && !hasBrandName) {
    validation.brandName = 'Required'
  }

  if (stepHasQuestion(questions, competitorsQuestion) && attributes.competitorsExist === 'yes' && _.isEmpty(_.reject(attributes.competitors, _.isEmpty))) {
    validation.competitors = [{ previewUrl: 'Required' }]
  }

  if (stepHasQuestion(questions, existingDesignsQuestion) && attributes.existingDesignsExist === 'yes' && _.isEmpty(_.reject(attributes.existingDesigns, _.isEmpty))) {
    validation.existingDesigns = [{ previewUrl: 'Required' }]
  }

  if (stepHasQuestion(questions, existingLogosQuestion) && attributes.existingDesignsExist === 'yes' && !attributes.hasExistingDesigns && _.isEmpty(_.reject(attributes.existingDesigns, _.isEmpty))) {
    validation.existingDesigns = [{ previewUrl: 'Required' }]
  }

  if (stepHasQuestion(questions, inspirationsQuestion) && attributes.inspirationsExist === 'yes' && _.isEmpty(_.reject(attributes.inspirations, _.isEmpty))) {
    validation.inspirations = [{ previewUrl: 'Required' }]
  }

  if (stepHasQuestion(questions, stockImagesQuestion) && attributes.stockImagesExist === 'yes' && _.isEmpty(_.reject(attributes.projectStockImages, _.isEmpty))) {
    validation.projectStockImages = [{ previewUrl: 'Required' }]
  }

  // if (stepHasQuestion(questions, examplesStep) && state.newProject.examplesStep.goodExamples.count < 3) {
  //   validation.goodExamples = `Select ${3 - state.newProject.examplesStep.goodExamples.count} more good examples to continue`
  // }

  return [
    _.isEmpty(validation),
    validation
  ]
}
