import React, { useEffect } from 'react'
import { useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import { createContestProject } from '../actions/newProjectBuilder'
import Spinner from '../components/Spinner'

const CreateNewProjectPage = () => {
  const dispatch = useDispatch()
  const { productKey } = useParams()

  useEffect(() => {
    dispatch(createContestProject({ productKey }))
  }, [])

  return (
    <Spinner />
  )
}

export default CreateNewProjectPage
