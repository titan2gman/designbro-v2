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

import styles from './IdeasOrSpecialRequirements.module.scss'

const IdeasOrSpecialRequirements = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [ideasOrSpecialRequirements, setIdeasOrSpecialRequirements] = useState(project.ideasOrSpecialRequirements || '')

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleChange = (event) => {
    setIdeasOrSpecialRequirements(event.target.value)
    delayedUpdateProject({ ideasOrSpecialRequirements: event.target.value })
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    dispatch(submitUpdateProject(projectId, { ideasOrSpecialRequirements }, step, true))
  }

  return (
    <>
      <ProjectPrice />
      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <Headline>Do you have any ideas or special requirements for the designers?</Headline>

            <Textarea
              value={ideasOrSpecialRequirements}
              onChange={handleChange}
              placeholder="Ideas or special requirements (optional)"
              inputClassName={styles.input}
            />
          </div>
        </div>

        <Footer
          backButton={<BackButton />}
          continueButton={<ContinueButton isValid>{ideasOrSpecialRequirements ? 'Continue →' : 'Skip this step →'}</ContinueButton>}
        />
      </form>
    </>
  )
}

export default IdeasOrSpecialRequirements
