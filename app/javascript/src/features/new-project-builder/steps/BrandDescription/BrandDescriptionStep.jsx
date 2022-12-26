import _ from 'lodash'
import React, { useEffect, useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import Headline from '../../components/Headline'
import Footer, { ContinueButton, BackButton } from '../../components/Footer'
import Textarea from '../../components/Textarea'
import ConfirmationModal from '../../components/ConfirmationModal'
import ProjectPrice from '../../components/ProjectPrice'

import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'

import { projectSelector } from '@selectors/newProjectBuilder'

import styles from './BrandDescriptionStep.module.scss'

const BrandDescriptionStep = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [brandDescription, setBrandDescription] = useState(project.brandDescription || '')
  const [confirmationModal, setConfirmationModal] = useState(false)

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleChange = (event) => {
    setBrandDescription(event.target.value)
    delayedUpdateProject({ brandDescription: event.target.value })
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    if (brandDescription) {
      dispatch(submitUpdateProject(projectId, { brandDescription }, step, true))
    } else {
      setConfirmationModal(true)
    }
  }

  const handleSkip = () => {
    setConfirmationModal(false)
    dispatch(submitUpdateProject(projectId, { brandDescription }, step, true))
  }

  const closeConfirmationModal = () => {
    setConfirmationModal(false)
  }

  return (
    <>
      <ProjectPrice />

      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <Headline>Can you tell us about the brand?<br />What is it that you do?</Headline>
            <p className={styles.hint}>Give us a bit of background, what makes you special?</p>

            <Textarea
              value={brandDescription}
              onChange={handleChange}
              placeholder="Brand description"
              inputClassName={styles.input}
            />
          </div>
        </div>

        <Footer
          backButton={<BackButton />}
          continueButton={<ContinueButton isValid>{brandDescription ? 'Continue →' : 'Skip this step →'}</ContinueButton>}
        />

        {!brandDescription && confirmationModal && <ConfirmationModal
          onSkip={handleSkip}
          onClose={closeConfirmationModal}
        />}
      </form>
    </>
  )
}

export default BrandDescriptionStep
