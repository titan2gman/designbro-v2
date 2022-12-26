import _ from 'lodash'
import React, { useEffect, useState, useCallback } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'

import Headline from '../../components/Headline'
import Footer, { ContinueButton } from '../../components/Footer'
import Input from '../../components/Input'
import SelectBrandModal from '../../components/SelectBrandModal'
import ProjectPrice from '../../components/ProjectPrice'

import MoneyBackGuaranteeHint from './MoneyBackGuaranteeHint'

import { updateProject, submitUpdateProject } from '../../actions/newProjectBuilder'
import { loadBrands } from '../../actions/brands'

import { projectSelector } from '@selectors/newProjectBuilder'
import { isAuthenticatedSelector } from '@selectors/me'

import styles from './BrandNameStep.module.scss'

const BrandNameStep = () => {
  const dispatch = useDispatch()
  const { projectId, step } = useParams()

  const project = useSelector(projectSelector)
  const isAuthenticated = useSelector(isAuthenticatedSelector)

  const [brandName, setBrandName] = useState(project.brandName || '')

  useEffect(() => {
    if (isAuthenticated) {
      dispatch(loadBrands())
    }
  }, [isAuthenticated])

  const delayedUpdateProject = useCallback(_.debounce(newAttrs => {
    dispatch(updateProject(projectId, newAttrs, step))
  }, 300), [projectId])

  const handleChange = (event) => {
    setBrandName(event.target.value)
    delayedUpdateProject({ brandName: event.target.value })
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    dispatch(submitUpdateProject(projectId, { brandName }, step, true))
  }

  const handleBrandSelect = (brandName) => {
    setBrandName(brandName)
    dispatch(updateProject(projectId, { brandName }, step))
  }

  return (
    <>
      <ProjectPrice />
      <form className={styles.form} onSubmit={handleSubmit}>
        <div className={styles.content}>
          <div className={styles.questionWrapper}>
            <Headline>Tell us the brand name<br/>you need in your logo</Headline>

            <Input
              value={brandName}
              onChange={handleChange}
              placeholder="Brand name"
              inputClassName={styles.input}
              append={
                isAuthenticated && <SelectBrandModal brandName={brandName} onChange={handleBrandSelect} />
              }
            />
          </div>
        </div>

        <Footer
          backButton={<MoneyBackGuaranteeHint />}
          continueButton={<ContinueButton isValid={!!brandName} popupContent="hmm..&nbsp;We&nbsp;really&nbsp;need&nbsp;to&nbsp;know your&nbsp;brand&nbsp;name&nbsp;before&nbsp;we&nbsp;move&nbsp;on">Continue →</ContinueButton>}
        />
      </form>
    </>
  )
}

export default BrandNameStep
