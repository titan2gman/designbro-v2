import React from 'react'
import { useSelector } from 'react-redux'
import { useRouteMatch } from 'react-router-dom'

import ProgressBar from '../../ProgressBar'
import { projectBuilderStepPercentageSelector } from '@selectors/newProjectBuilder'

const HeaderProgressBar = () => {
  const match = useRouteMatch('/new-project/:projectId/:step')

  if (!match || ['details', 'checkout', 'success'].includes(match.params.step)) {
    return null
  }

  const progressPercentage = useSelector((state) => projectBuilderStepPercentageSelector(state, match.params.step))

  return (
    <ProgressBar progressPercentage={progressPercentage} />
  )
}

export default HeaderProgressBar
