import _ from 'lodash'
import cn from 'classnames'
import React, { useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import Headline from '../../components/Headline'
import Footer, { ContinueButton, BackButton } from '../../components/Footer'
import Input from '../../components/Input'
import ColorPicker from '../../components/ColorPicker'
import ProjectPrice from '../../components/ProjectPrice'

import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'

import { projectSelector } from '@selectors/newProjectBuilder'

import styles from './ColorsStep.module.scss'

import NoColorsIcon from './no-colors.newsvg'
import HasColorsIcon from './has-colors.newsvg'

const Colors = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)

  const [colors, setColors] = useState(project.newColors)
  const [colorsComment, setColorComment] = useState(project.colorsComment)
  const [hasColors, setHasColors] = useState(!!project.newColors.length)

  const handleNoColorsClick = () => {
    setHasColors(false)

    dispatch(submitUpdateProject(projectId, { newColors: [], colorsComment: null }, step, true))
  }

  const handleHasColorsClick = () => {
    setHasColors(true)
  }

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleColorCommentChange = (event) => {
    const colorsComment = event.target.value

    setColorComment(colorsComment)

    delayedUpdateProject({ newColors: colors, colorsComment })
  }

  const handleSubmit = (event) => {
    event.preventDefault()

    dispatch(submitUpdateProject(projectId, { newColors: colors, colorsComment }, step, true))
  }

  const handleColorChange = (colors) => {
    setColors(colors)

    dispatch(updateProject(projectId, { newColors: colors, colorsComment }, step))
  }

  return (
    <>
      <ProjectPrice />

      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <div className={cn(styles.optionsWrapper, { [styles.faded]: hasColors })}>
              <Headline>Can you show us inspirational colors you think look great?</Headline>

              <div className={cn(styles.option, { [styles.selected]: hasColors })} onClick={handleHasColorsClick}>
                <HasColorsIcon className={styles.optionImg} />
                Yes, let’s pick some color
              </div>
              <div className={styles.option} onClick={handleNoColorsClick}>
                <NoColorsIcon className={styles.optionImg} />
                No, let the designer decide
              </div>
            </div>

            {hasColors && (
              <>
                <Headline>Select your color here</Headline>

                <ColorPicker
                  colors={colors}
                  onChange={handleColorChange}
                >
                  <div className={styles.inputs}>
                    <Input
                      value={colorsComment || ''}
                      onChange={handleColorCommentChange}
                      placeholder="or enter your color (codes) manually"
                    />
                  </div>
                </ColorPicker>
              </>
            )}
          </div>
        </div>

        <Footer
          backButton={<BackButton />}
          continueButton={hasColors && (
            <ContinueButton isValid>
              {!colors.length ? 'Skip this step →' : 'Continue →'}
            </ContinueButton>
          )}
        />
      </form>
    </>
  )
}

export default Colors
