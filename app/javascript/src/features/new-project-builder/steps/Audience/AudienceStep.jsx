import React, { useEffect, useState } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'
import countries from 'country-list'

import Footer, { BackButton, ContinueButton } from '../../components/Footer'
import Headline from '../../components/Headline'
import Slider from '../../components/Slider'
import MultipleSelect from '../../components/MultipleSelect'
import ProjectPrice from '../../components/ProjectPrice'

import audienceQuestions from '@constants/audienceQuestions'
import { projectAudienceSelector } from '@selectors/newProjectBuilder'

import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'
import { showSignUpModal } from '@actions/modal'
import { isAuthenticatedSelector } from '@selectors/me'

import styles from './AudienceStep.module.scss'

const allCountriesList = countries.getCodes().map((code) => ({
  id: code,
  text: countries.getName(code),
}))

const Audience = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const projectBrandDna = useSelector(projectAudienceSelector)
  const isAuthenticated = useSelector(isAuthenticatedSelector)

  const [values, setValues] = useState(projectBrandDna)

  const handleChange = (name, value) => {
    setValues({ ...values, [name]: value })
  }

  const handleAfterChange = () => {
    dispatch(updateProject(projectId, values, step))
  }

  const handleAddCountry = (value) => {
    setValues({
      ...values,
      brandDnaTargetCountryCodes: [
        ...values.brandDnaTargetCountryCodes,
        value.id
      ]
    })
  }

  const handleDeleteCountry = (index) => {
    setValues({
      ...values,
      brandDnaTargetCountryCodes: [
        ...values.brandDnaTargetCountryCodes.slice(0, index),
        ...values.brandDnaTargetCountryCodes.slice(index + 1)
      ]
    })
  }

  useEffect(() => {
    dispatch(updateProject(projectId, values, step))
  }, [values.brandDnaTargetCountryCodes])

  const handleSubmit = (event) => {
    event.preventDefault()
    if (isAuthenticated) {
      dispatch(submitUpdateProject(projectId, values, step, true))
    } else {
      dispatch(showSignUpModal({
        title: 'Save your progress',
        successCallback: signUpSuccessCallback,
        optional: true
      }))
    }
  }

  const signUpSuccessCallback = () => {
    dispatch(submitUpdateProject(projectId, values, step, true))
  }

  const countryValues = values.brandDnaTargetCountryCodes.map((code) => ({
    id: code,
    text: countries.getName(code)
  }))

  return (
    <>
      <ProjectPrice />
      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <Headline>Tell us about your target audience</Headline>

          <p className={styles.hint}>
            Move the sliders to let us know which of the following<br/>
            best shows who your customer is.
          </p>

          {audienceQuestions.map((question, index) => (
            <Slider
              key={index}
              {...question}
              value={values[question.name]}
              onChange={handleChange}
              onAfterChange={handleAfterChange}
            />
          ))}

          <div className={styles.countriesSelectWrapper}>
            <MultipleSelect
              options={allCountriesList}
              placeholder="Which countries will your design be aimed at?"
              values={countryValues}
              onAddition={handleAddCountry}
              onDelete={handleDeleteCountry}
            />
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

export default Audience
