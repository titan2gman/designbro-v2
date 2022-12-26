import _ from 'lodash'
import React, { useEffect, useState, useCallback } from 'react'
import { Popup } from 'semantic-ui-react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import Footer, { BackButton, ContinueButton } from '../../components/Footer'
import Headline from '../../components/Headline'
import Slider from '../../components/Slider'
import ProjectPrice from '../../components/ProjectPrice'

import brandDnaQuestions from '@constants/brandDnaQuestions'
import { projectBrandDnaSelector } from '@selectors/newProjectBuilder'

import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'

import styles from './BrandDnaStep.module.scss'

const PopupComponent = ({ label }) => (
  <Popup
    trigger={<span></span>}
    content={label}
    open
    position="top center"
    offset={'0, 20'}
    className={styles.popup}
  />
)

const BrandDnaStep = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()
  const projectBrandDna = useSelector(projectBrandDnaSelector)
  const [values, setValues] = useState(projectBrandDna)
  const [marksAreVisible, setMarksAreVisible] = useState(true)

  const handleChange = (name, value) => {
    if (marksAreVisible) {
      setMarksAreVisible(false)
    }

    setValues({ ...values, [name]: value })
  }

  const handleAfterChange = () => {
    dispatch(updateProject(projectId, values, step))
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    dispatch(submitUpdateProject(projectId, values, step, true))
  }

  const marks = marksAreVisible ? {
    2: (
      <PopupComponent label={'Very traditional'} />
    ),
    5: (
      <PopupComponent label={'Neutral'} />
    ),
    8: (
      <PopupComponent label={'Super modern'} />
    )
  } : {}

  return (
    <>
      <ProjectPrice />

      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <Headline>Describe your brand DNA</Headline>

          <p className={styles.hint}>
            Move the sliders to let us know which of the following best fits<br/>
            the image / identity of the brand you are trying to create.
          </p>

          <div className={styles.sliders}>
            {brandDnaQuestions.map((question, index) => (
              <Slider
                key={index}
                {...question}
                marks={index === 0 ? marks : {}}
                value={values[question.name]}
                onChange={handleChange}
                onAfterChange={handleAfterChange}
              />
            ))}
          </div>
        </div>

        <Footer
          backButton={<BackButton />}
          continueButton={(
            <ContinueButton isValid>Continue →</ContinueButton>
          )}
        />
      </form>
    </>
  )
}

export default BrandDnaStep
