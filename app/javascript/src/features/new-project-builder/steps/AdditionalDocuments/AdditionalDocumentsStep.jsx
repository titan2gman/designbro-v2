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

import styles from './AdditionalDocumentsStep.module.scss'

import NoAdditionalDocumentsIcon from './no-additional-documents.newsvg'
import HasAdditionalDocumentsIcon from './has-additional-documents.newsvg'

const AdditionalDocuments = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [additionalDocuments, setAdditionalDocuments] = useState(project.additionalDocuments)
  const [hasAdditionalDocuments, setHasAdditionalDocuments] = useState(!!project.additionalDocuments.length)
  const [activeDesignId, setActiveDesignId] = useState(_.get(additionalDocuments, [additionalDocuments.length - 1, 'id']), null)

  const activeDesign = _.find(additionalDocuments, { id: activeDesignId })

  const handleNotExistClick = () => {
    setHasAdditionalDocuments(false)

    dispatch(submitUpdateProject(projectId, { additionalDocuments: [] }, step, true))
  }

  const handleExistClick = () => {
    setHasAdditionalDocuments(true)
  }

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleCommentChange = (event) => {
    const comment = event.target.value

    const nextAdditionalDocuments = additionalDocuments.map((exDes) => {
      return activeDesignId === exDes.id ? { ...exDes, comment } : exDes
    })

    setAdditionalDocuments(nextAdditionalDocuments)

    delayedUpdateProject({ additionalDocuments: nextAdditionalDocuments })
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    dispatch(submitUpdateProject(projectId, { additionalDocuments }, step, true))
  }

  const handleImageUploaderChange = (designs) => {
    const nextDesigns = _.reject(designs, { _destroy: true })

    setAdditionalDocuments(nextDesigns)

    dispatch(submitUpdateProject(projectId, { additionalDocuments: designs }, step))
  }

  const handleImageUpload = (file) => {
    return dispatch(uploadProjectFile({
      projectId,
      file,
      entity: 'additional_document'
    }))
  }

  return (
    <>
      <ProjectPrice />
      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <div className={cn(styles.optionsWrapper, { [styles.faded]: hasAdditionalDocuments })}>
              <Headline>Would you like to upload anything else for the designers?</Headline>

              <p className={styles.hint}>
                eg. style guides, moodboards, your own scribbles etc.
              </p>

              <div className={cn(styles.option, { [styles.selected]: hasAdditionalDocuments })} onClick={handleExistClick}>
                <HasAdditionalDocumentsIcon className={styles.optionImg} />
                Let’s upload more items
              </div>

              <div className={cn(styles.option)} onClick={handleNotExistClick}>
                <NoAdditionalDocumentsIcon className={styles.optionImg} />
                Take me to checkout
              </div>

            </div>

            {hasAdditionalDocuments && (
              <>
                <Headline>Upload your additonal items here</Headline>

                <ImageUploader
                  designs={additionalDocuments}
                  activeDesign={activeDesign}
                  fileExtensions={['jpg', 'jpeg', 'png', 'pdf', 'docx', 'doc', 'pptx', 'ppt', 'sketch', 'xd', 'ai', 'indd', 'psd', 'eps', 'txt', 'rtf', 'svg']}
                  fileSize={25}
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
          continueButton={hasAdditionalDocuments && (
            <ContinueButton isValid>
              {!additionalDocuments.length ? 'Skip this step →' : 'Continue →'}
            </ContinueButton>
          )}
        />
      </form>
    </>
  )
}

export default AdditionalDocuments
