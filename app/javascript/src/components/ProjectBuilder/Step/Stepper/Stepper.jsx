import React from 'react'
import { StepGroup, Step } from '@components/Step'

const Stepper = ({ steps, stepPosition }) => {
  if (steps.length < 2) {
    return null
  }

  return (
    <StepGroup currentStep={stepPosition}>
      {steps.map((step, index) => (
        <Step
          key={step.position}
          title={step.name}
          completed={step.position < stepPosition}
          active={step.position === stepPosition}
        />
      ))}
    </StepGroup>
  )
}

export default Stepper
