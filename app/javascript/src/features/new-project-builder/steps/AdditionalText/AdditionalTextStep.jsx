import _ from 'lodash'
import React, { useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import Headline from '../../components/Headline'
import Footer, { ContinueButton, BackButton } from '../../components/Footer'
import Textarea from '../../components/Textarea'
import ProjectPrice from '../../components/ProjectPrice'

import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'

import { projectSelector } from '@selectors/newProjectBuilder'

import styles from './AdditionalTextStep.module.scss'

const AdditionalTextStep = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [brandAdditionalText, setBrandAdditionalText] = useState(project.brandAdditionalText || '')

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleChange = (event) => {
    setBrandAdditionalText(event.target.value)
    delayedUpdateProject({ brandAdditionalText: event.target.value })
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    dispatch(submitUpdateProject(projectId, { brandAdditionalText }, step, true))
  }

  return (
    <>
      <ProjectPrice />
      <form className={styles.form} onSubmit={handleSubmit}>

        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <Headline>Do you have a tagline, slogan or any additional text for your logo?</Headline>
            <p className={styles.hint}>eg. ‘Founded in 2020’ or ‘The best bakery in town’.</p>

            <Textarea
              value={brandAdditionalText}
              onChange={handleChange}
              placeholder="Tagline, slogan or additional text (optional)"
              inputClassName={styles.input}
            />
          </div>
        </div>

        <Footer
          backButton={<BackButton />}
          continueButton={<ContinueButton isValid>{brandAdditionalText ? 'Continue →' : 'Skip this step →'}</ContinueButton>}
        />
      </form>
    </>
  )
}

export default AdditionalTextStep
