import React from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { Link, useParams } from 'react-router-dom'
import { prevProjectBuilderStepSelector } from '@selectors/newProjectBuilder'

import styles from './BackButton.module.scss'

const BackButton = () => {
  const { projectId, step } = useParams()

  const prevProjectBuilderStep = useSelector((state) => prevProjectBuilderStepSelector(state, step))

  return (
    <Link to={`/new-project/${projectId}/${prevProjectBuilderStep.path}`} className={styles.btn}>← <span className={styles.label}>Back</span></Link>
  )
}

export default BackButton
