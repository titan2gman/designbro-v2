import _ from 'lodash'
import cn from 'classnames'
import React, { useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import Headline from '../../components/Headline'
import Footer, { ContinueButton, BackButton } from '../../components/Footer'
import Input from '../../components/Input'
import ImageUploader from '../../components/ImagesUploader'
import ProjectPrice from '../../components/ProjectPrice'

import { updateProject, submitUpdateProject, uploadProjectFile } from '../../actions/newProjectBuilder'

import { projectSelector } from '@selectors/newProjectBuilder'

import styles from './ExistingDesignStep.module.scss'

import NoExistingDesignIcon from './no-existing-design.newsvg'
import HasExistingDesignIcon from './has-existing-design.newsvg'

const ExistingDesigns = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [existingDesigns, setExistingDesigns] = useState(project.existingDesigns)
  const [hasExistingDesign, setHasExistingDesign] = useState(!!project.existingDesigns.length)
  const [activeDesignId, setActiveDesignId] = useState(_.get(existingDesigns, [existingDesigns.length - 1, 'id']), null)

  const activeDesign = _.find(existingDesigns, { id: activeDesignId })

  const handleNotExistClick = () => {
    setHasExistingDesign(false)

    dispatch(submitUpdateProject(projectId, { existingDesigns: [] }, step, true))
  }

  const handleExistClick = () => {
    setHasExistingDesign(true)
  }

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleCommentChange = (event) => {
    const comment = event.target.value

    const nextExistingDesigns = existingDesigns.map((exDes) => {
      return activeDesignId === exDes.id ? { ...exDes, comment } : exDes
    })

    setExistingDesigns(nextExistingDesigns)

    delayedUpdateProject({ existingDesigns: nextExistingDesigns })
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    dispatch(submitUpdateProject(projectId, { existingDesigns }, step, true))
  }

  const handleImageUploaderChange = (designs) => {
    const nextDesigns = _.reject(designs, { _destroy: true })

    setExistingDesigns(nextDesigns)

    dispatch(submitUpdateProject(projectId, { existingDesigns: designs }, step))
  }

  const handleImageUpload = (file) => {
    return dispatch(uploadProjectFile({
      projectId,
      file,
      entity: 'existing_logo'
    }))
  }

  return (
    <>
      <ProjectPrice />

      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <div className={cn(styles.optionsWrapper, { [styles.faded]: hasExistingDesign })}>
              <Headline>What are we going to create for you?</Headline>
              <div className={styles.option} onClick={handleNotExistClick}>
                <NoExistingDesignIcon className={styles.optionImg} />

                A brand new design
              </div>
              <div className={cn(styles.option, { [styles.selected]: hasExistingDesign })} onClick={handleExistClick}>
                <HasExistingDesignIcon className={styles.optionImg} />

                Change existing design
              </div>
            </div>

            {hasExistingDesign && (
              <>
                <Headline>Upload your existing design here</Headline>

                <ImageUploader
                  designs={existingDesigns}
                  activeDesign={activeDesign}
                  fileExtensions={['jpg', 'jpeg', 'png', 'ai', 'eps', 'pdf', 'psd', 'svg']}
                  fileSize={10}
                  onChange={handleImageUploaderChange}
                  onUpload={handleImageUpload}
                  setActiveDesignId={setActiveDesignId}
                >
                  <div className={styles.inputs}>
                    <Input
                      value={activeDesign && activeDesign.comment || ''}
                      onChange={handleCommentChange}
                      placeholder="Comment (optional)"
                    />
                  </div>
                </ImageUploader>
              </>
            )}
          </div>
        </div>

        <Footer
          backButton={<BackButton />}
          continueButton={hasExistingDesign && (
            <ContinueButton isValid>
              {!existingDesigns.length ? 'Skip this step →' : 'Continue →'}
            </ContinueButton>
          )}
        />
      </form>
    </>
  )
}

export default ExistingDesigns
