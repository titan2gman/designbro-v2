import React, { useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import { loadProject } from '../actions/newProjectBuilder'

import Spinner from '../components/Spinner'
import {
  AdditionalDocumentsStep,
  AdditionalTextStep,
  AudienceStep,
  BrandDnaStep,
  BrandNameStep,
  BrandDescriptionStep,
  CheckoutStep,
  ColorsStep,
  CompetitorsStep,
  DetailsStep,
  ExamplesStep,
  ExistingDesignStep,
  InspirationsStep,
  IdeasOrSpecialRequirementsStep
} from '../steps'

import { projectBuilderStepSelector } from '@selectors/newProjectBuilder'

const inProgressSelector = (state) => state.newProjectBuilder.loadInProgress || !state.newProjectBuilder.project.id

const steps = {
  AdditionalDocumentsStep,
  AdditionalTextStep,
  AudienceStep,
  BrandDnaStep,
  BrandNameStep,
  BrandDescriptionStep,
  CheckoutStep,
  ColorsStep,
  CompetitorsStep,
  DetailsStep,
  ExamplesStep,
  ExistingDesignStep,
  InspirationsStep,
  IdeasOrSpecialRequirementsStep
}

const NewProjectStepPage = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  useEffect(() => {
    dispatch(loadProject(projectId))
  }, [])

  const inProgress = useSelector(inProgressSelector)

  const projectBuilderStep = useSelector((state) => projectBuilderStepSelector(state, step))

  if (inProgress) {
    return <Spinner />
  }

  const StepComponent = steps[projectBuilderStep.componentName]

  return (
    <StepComponent />
  )
}

export default NewProjectStepPage
