import React, { useEffect, useState } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import Footer, { BackButton, ContinueButton } from '../../components/Footer'
import Spinner from '../../components/Spinner'
import Headline from '../../components/Headline'
import ProgressBar from '../../components/ProgressBar'
import BrandExampleTile from './BrandExampleTile'
import { Popup } from 'semantic-ui-react'
import ProjectPrice from '../../components/ProjectPrice'

import { projectBrandExampleIdsSelector } from '@selectors/newProjectBuilder'

import { brandExamplesSelector, brandExamplesLoadInProgressSelector } from '../../selectors/brandExamples'

import { loadBrandExamples } from '../../actions/brandExamples'
import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'

import styles from './ExamplesStep.module.scss'

const ExamplesStep = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()
  const inProgress = useSelector(brandExamplesLoadInProgressSelector)
  const brandExamples = useSelector(brandExamplesSelector)
  const projectBrandExampleIds = useSelector(projectBrandExampleIdsSelector)

  useEffect(() => {
    if (!brandExamples.length) {
      dispatch(loadBrandExamples())
    }
  }, [])

  const [brandExampleIds, setBrandExampleIds] = useState(projectBrandExampleIds || [])
  const [disabledClicked, setDisabledClicked] = useState(false)

  const handleClick = (newId) => {
    let newIds

    if (brandExampleIds.includes(newId)) {
      newIds = brandExampleIds.filter((id) => id !== newId)
    } else {
      newIds = [...brandExampleIds, newId]
    }

    setBrandExampleIds(newIds)
    setDisabledClicked(false)
    dispatch(updateProject(projectId, { brandExampleIds: newIds }, step))
  }

  const handleDisabledClick = () => {
    setDisabledClicked(true)
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    dispatch(submitUpdateProject(projectId, { brandExampleIds }, step, true))
  }

  const maxExamplesCountReached = brandExampleIds.length === 5

  const continueButton = (
    <ContinueButton
      isValid={brandExampleIds.length >= 3}
      popupContent="oops...&nbsp;Select&nbsp;at&nbsp;least&nbsp;3&nbsp;logo&nbsp;designs that&nbsp;you&nbsp;like&nbsp;before&nbsp;we&nbsp;continue"
    >
      Continue →
    </ContinueButton>
  )

  return (
    <>
      <ProjectPrice />
      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <Headline>Select designs you like</Headline>

            <p className={styles.hint}>Select at least 3 designs that you think fit your brand to help the designers understand the visual style.</p>

            {inProgress && <Spinner />}

            <div className={styles.brandExamples}>
              {brandExamples.map((example) => {
                const isSelected = brandExampleIds.includes(example.id)

                return (
                  <BrandExampleTile
                    key={example.id}
                    example={example}
                    isSelected={isSelected}
                    isDisabled={maxExamplesCountReached && !isSelected}
                    onClick={handleClick}
                    onDisabledClick={handleDisabledClick}
                  />
                )
              })}
            </div>
          </div>
        </div>

        <Footer
          backButton={<BackButton />}
          continueButton={(
            <>
              {disabledClicked ? (
                <Popup
                  content="You&nbsp;selected&nbsp;a&nbsp;maximum&nbsp;of&nbsp;5&nbsp;designs, first&nbsp;deselect&nbsp;a&nbsp;design&nbsp;if&nbsp;you&nbsp;want&nbsp;to&nbsp;change&nbsp;your&nbsp;selection"
                  on="click"
                  open
                  position="top center"
                  className={styles.popup}
                  trigger={continueButton}
                />
              ) : continueButton}
            </>
          )}
          validation={(
            <div className={styles.validationWrapper}>
              <div className={styles.progressBarWrapper}>
                <ProgressBar progressPercentage={brandExampleIds.length * 100 / 5} successThreshold={60} />
              </div>
              <div className={styles.validationLabel}>{brandExampleIds.length}<span className={styles.validationMaxCount}>/5</span> <span className={styles.selectedLabel}>Selected</span></div>
            </div>
          )}
        />
      </form>
    </>
  )
}

export default ExamplesStep
