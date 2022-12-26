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

import styles from './CompetitorsStep.module.scss'

import NoCompetitorsIcon from './no-competitors.newsvg'
import HasCompetitorsIcon from './has-competitors.newsvg'

const Competitors = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [competitors, setCompetitors] = useState(project.competitors)
  const [hasCompetitors, setHasExistingDesign] = useState(!!project.competitors.length)
  const [activeDesignId, setActiveDesignId] = useState(_.get(competitors, [competitors.length - 1, 'id']), null)

  const activeDesign = _.find(competitors, { id: activeDesignId })

  const handleNoCompetitorsClick = () => {
    setHasExistingDesign(false)

    dispatch(submitUpdateProject(projectId, { competitors: [] }, step, true))
  }

  const handleHasCompetitorsClick = () => {
    setHasExistingDesign(true)
  }

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleCommentChange = (event) => {
    const comment = event.target.value

    const nextCompetitors = competitors.map((exDes) => {
      return activeDesign.id === exDes.id ? { ...exDes, comment } : exDes
    })

    setCompetitors(nextCompetitors)

    delayedUpdateProject({ competitors: nextCompetitors })
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    dispatch(submitUpdateProject(projectId, { competitors }, step, true))
  }

  const handleImageUploaderChange = (competitors) => {
    const nextCompetitors = _.reject(competitors, { _destroy: true })

    setCompetitors(nextCompetitors)

    dispatch(submitUpdateProject(projectId, { competitors }, step))
  }

  const handleImageUpload = (file) => {
    return dispatch(uploadProjectFile({
      projectId,
      file,
      entity: 'competitor_logo'
    }))
  }


  return (
    <>
      <ProjectPrice />
      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <div className={cn(styles.optionsWrapper, { [styles.faded]: hasCompetitors })}>
              <Headline>Can you show us your competitors?</Headline>

              <p className={styles.hint}>Show your competitors to help the designers understand the market in which you operate.</p>

              <div className={cn(styles.option, { [styles.selected]: hasCompetitors })} onClick={handleHasCompetitorsClick}>
                <HasCompetitorsIcon className={styles.optionImg} />

                Yes, I can show competitors
              </div>
              <div className={styles.option} onClick={handleNoCompetitorsClick}>
                <NoCompetitorsIcon className={styles.optionImg} />

                No, don’t show competitors
              </div>
            </div>

            {hasCompetitors && (
              <>
                <Headline>Upload your competitors here</Headline>

                <ImageUploader
                  designs={competitors}
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
          continueButton={hasCompetitors && (
            <ContinueButton isValid>
              {!competitors.length ? 'Skip this step →' : 'Continue →'}
            </ContinueButton>
          )}
        />
      </form>
    </>
  )
}

export default Competitors
