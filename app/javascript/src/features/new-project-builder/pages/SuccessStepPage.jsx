import React, { useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import { loadProject } from '../actions/newProjectBuilder'

import Spinner from '../components/Spinner'
import { SuccessStep } from '../steps'

const inProgressSelector = (state) => state.newProjectBuilder.loadInProgress || !state.newProjectBuilder.project.id

const SuccessStepPage = () => {
  const dispatch = useDispatch()
  const { projectId } = useParams()

  useEffect(() => {
    dispatch(loadProject(projectId))
  }, [])

  const inProgress = useSelector(inProgressSelector)

  if (inProgress) {
    return <Spinner />
  }

  return (
    <SuccessStep />
  )
}

export default SuccessStepPage
