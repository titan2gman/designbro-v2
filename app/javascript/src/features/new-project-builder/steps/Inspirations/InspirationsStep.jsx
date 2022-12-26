import _ from 'lodash'
import cn from 'classnames'
import React, { useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import Headline from '../../components/Headline'
import Footer, { ContinueButton, BackButton } from '../../components/Footer'
import Input from '../../components/Input'
import ImageUploader from '../../components/ImagesUploader'
import ConfirmationModal from '../../components/ConfirmationModal'
import ProjectPrice from '../../components/ProjectPrice'

import { updateProject, submitUpdateProject, uploadProjectFile } from '../../actions/newProjectBuilder'

import { projectSelector } from '@selectors/newProjectBuilder'

import styles from './InspirationsStep.module.scss'

import NoInspirationsIcon from './no-inspirations.newsvg'
import HasInspirationIcon from './has-inspirations.newsvg'

const Inspirations = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [inspirations, setInspirations] = useState(project.inspirations)
  const [hasInspirations, setHasInspiration] = useState(!!project.inspirations.length)
  const [activeDesignId, setActiveDesignId] = useState(_.get(inspirations, [inspirations.length - 1, 'id']), null)
  const [confirmationModal, setConfirmationModal] = useState(false)

  const activeDesign = _.find(inspirations, { id: activeDesignId })

  const handleNoInspirationsClick = () => {
    setHasInspiration(false)
    setConfirmationModal(true)
  }

  const handleHasInspirationsClick = () => {
    setHasInspiration(true)
  }

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleCommentChange = (event) => {
    const comment = event.target.value

    const nextInspirations = inspirations.map((exDes) => {
      return activeDesign.id === exDes.id ? { ...exDes, comment } : exDes
    })

    setInspirations(nextInspirations)

    delayedUpdateProject({ inspirations: nextInspirations })
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    if (inspirations.length) {
      dispatch(submitUpdateProject(projectId, { inspirations }, step, true))
    } else {
      setConfirmationModal(true)
    }
  }

  const handleImageUploaderChange = (designs) => {
    const nextDesigns = _.reject(designs, { _destroy: true })

    setInspirations(nextDesigns)

    dispatch(submitUpdateProject(projectId, { inspirations: designs }, step))
  }

  const handleImageUpload = (file) => {
    return dispatch(uploadProjectFile({
      projectId,
      file,
      entity: 'inspiration_image'
    }))
  }

  const handleSkip = () => {
    setConfirmationModal(false)
    dispatch(submitUpdateProject(projectId, { inspirations }, step, true))
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
            <div className={cn(styles.optionsWrapper, { [styles.faded]: hasInspirations })}>
              <Headline>Can you show us inspirational designs you think look great?</Headline>

              <div className={cn(styles.option, { [styles.selected]: hasInspirations })} onClick={handleHasInspirationsClick}>
                <HasInspirationIcon className={styles.optionImg} />
                Yes, I can show inspiration
              </div>

              <div className={styles.option} onClick={handleNoInspirationsClick}>
                <NoInspirationsIcon className={styles.optionImg} />
                No, don’t show inspiration
              </div>
            </div>

            {hasInspirations && (
              <>
                <Headline>Upload your inspiration here</Headline>

                <ImageUploader
                  designs={inspirations}
                  activeDesign={activeDesign}
                  fileExtensions={['jpg', 'jpeg', 'png', 'svg']}
                  fileSize={2}
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
          continueButton={hasInspirations && (
            <ContinueButton isValid>
              {!inspirations.length ? 'Skip this step →' : 'Continue →'}
            </ContinueButton>
          )}
        />

        {confirmationModal && <ConfirmationModal
          onSkip={handleSkip}
          onClose={closeConfirmationModal}
        />}
      </form>
    </>
  )
}

export default Inspirations
