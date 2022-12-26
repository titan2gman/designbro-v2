import _ from 'lodash'
import React, { Component } from 'react'
import { Redirect } from 'react-router-dom'
import classNames from 'classnames'

import Examples from './Examples'
import Details from './Details'
import Checkout from './Checkout'
import PackagingType from './PackagingType'
import Header from './Header'
import Stepper from './Stepper'
import SubmitPanel from '../SubmitPanel'

import {
  InputBriefing as Input,
  TextareaBriefing as Textarea,
  Slider,
  CountriesSelect
} from '../inputs'

import BrandSelector from './BrandSelector'
import OptionalBrandSelector from './OptionalBrandSelector'
import Authentication from './Authentication'
import ExistingDesigns from './ExistingDesigns'
import ExistingLogos from './ExistingLogos'
import Inspirations from './Inspirations'
import Competitors from './Competitors'
import AdditionalDocuments from './AdditionalDocuments'
import ColorsPicker from './ColorsPicker'
import StockImages from './StockImages'

import Button from '@components/Button'

import styles from './NewProjectStep.module.scss'
import { history } from '../../../history'
import { saveGACheckoutEvent } from '../../../utils/googleAnalytics'

const components = {
  PackagingType,
  Slider,
  Examples,
  CountriesSelect,
  Input,
  Textarea,
  BrandSelector,
  OptionalBrandSelector,
  Authentication,
  Inspirations,
  Competitors,
  ExistingDesigns,
  ExistingLogos,
  AdditionalDocuments,
  ColorsPicker,
  Details,
  Checkout,
  StockImages
}

const getErrorMessage = (errors) => {
  if (_.isEmpty(errors)) {
    return
  }

  return errors.goodExamples || 'Fill in all mandatory fields'
}

class NewProjectStep extends Component {
  componentDidMount () {
    this.saveGAEvent()
  }

  componentDidUpdate (prevProps) {
    if (prevProps.openStep.path !== this.props.openStep.path) {
      this.saveGAEvent()
    }
  }

  saveGAEvent = () => {
    const { redirectPath, product, openStep, price } = this.props

    if (!redirectPath) {
      saveGACheckoutEvent({
        price,
        product,
        step: openStep
      })
    }
  }

  handleSubmit = (e) => {
    e.preventDefault()

    const { submitStep, openStep } = this.props

    submitStep(openStep)
  }

  handleBack = () => {
    const { backPath } = this.props

    history.push(backPath)
  }

  render () {
    const { attributes, hasPaidProject, redirectPath, questions, isStepperVisible, isSubmitPanelVisible, isContinueDisabled, backPath, errors } = this.props

    if (redirectPath) {
      return <Redirect to={redirectPath} />
    }

    const errorMessage = getErrorMessage(errors)

    return (
      <div className={classNames('new-project-step', styles.wrapper)}>
        <Header />

        {isStepperVisible && <Stepper />}

        {questions.map((question, index) => {
          const Component = components[question.componentName]
          const attributeName = _.camelCase(question.attributeName)

          if (question.mandatory || !hasPaidProject || (question.attributeName && !attributes[attributeName])) {
            return (
              <Component
                key={index}
                {...question.props}
                name={attributeName}
                onBackButtonClick={this.handleBack}
              />
            )
          }

          return null
        })}

        {isSubmitPanelVisible && (
          <SubmitPanel
            isBackButtonVisible={!!backPath}
            onBackButtonClick={this.handleBack}
          >
            <>
              <Button
                disabled={isContinueDisabled}
                onClick={this.handleSubmit}
              >
                Continue
              </Button>

              {errorMessage && (
                <div className={classNames('text-center in-pink-500', styles.submitError)}>{errorMessage}</div>
              )}
            </>
          </SubmitPanel>
        )}
      </div>
    )
  }
}

NewProjectStep.defaultProps = {
  questions: []
}

export default NewProjectStep
