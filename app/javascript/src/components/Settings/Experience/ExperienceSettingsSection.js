import React, { useState } from 'react'
import { Link } from 'react-router-dom'
// import PropTypes from 'prop-types'
import classNames from 'classnames'
import MaterialSelect from '@components/inputs/MaterialSelectPlain'
import _ from 'lodash'
import Row from '@components/inputs/Row'
import PortfolioUploader from '@components/inputs/PortfolioUploader'
import { designExperienceOptions } from '@constants'

const renderStateComponent = (initialExperience, experience, category) => {
  const isPendingState = ['draft', 'pending'].includes(experience.state)
  const isNewExperienceSet = !initialExperience && experience
  const isExperienceChanged = initialExperience && experience.experience !== initialExperience.experience

  if (isPendingState || isNewExperienceSet || isExperienceChanged) {
    return <NotApproved/>
  }
  if (experience.state === 'approved') {
    return <Approved to={`/d/discover/${category.id}`}/>
  }
  if (experience.state === 'disapproved') {
    return <Disapproved/>
  }
}

const Approved = ({ to }) => (
  <p className="settings-item__text">
    <span className="in-green-300">Approved </span>
    <Link to={to} className="text-underline in-black">
      Discover projects now
    </Link>
  </p>
)

const Disapproved = () => (
  <p className="settings-item__text">
    <span className="in-pink-400">Disapproved </span>
  </p>
)

const NotApproved = () => (
  <p className="settings-item__text">Wasn’t reviewed</p>
)

const DesignerSettingsExperienceSection = ({
  works,
  category,
  changePortfolioWorkAttribute,
  uploadPortfolioFile,
  changeProfileExperience,
  experience,
  initialExperience,
  validation,
}) => {
  const [open, setToggle] = useState(false)

  const showWorks = experience && (experience.experience !== 'no_experience')

  return (
    <div className="settings-table__row m-b-20">
      <div className="settings-table__row-top row">
        <div className="col-lg-4">
          <h3 className="settings-item__title">{category.name}</h3>
        </div>
        <div className="col-lg-4">
          <MaterialSelect
            name={category.id}
            options={designExperienceOptions}
            value={experience && experience.experience}
            onChange={(...args) => {
              changeProfileExperience(...args)
              setToggle(true)
            }}
            placeholder="Set your experience"
          />
        </div>
        <div className="col-lg-4">
          <div className="settings-table__row-trigger-area">
            {experience && renderStateComponent(initialExperience, experience, category)}

            {showWorks &&
            <div
              onClick={() => setToggle(!open)}
              className="settings-table__row-trigger settings-table__row-trigger--rotated">

              <i className={classNames({ 'icon-arrow-down': !open, 'icon-arrow-up': open })}/>
            </div>
            }
          </div>
        </div>
        <div className="width-100">
          {showWorks && open &&
          <Row columnClass="col-sm-6 col-md-4 col-xl-3">
            {works.map((work, index) => (
              <PortfolioUploader
                key={index}
                index={index}
                work={work}
                previewUrl={work.previewUrl}
                validation={_.get(validation, [index], {})}
                productCategoryId={category.id}
                onUpload={uploadPortfolioFile(category.id, index)}
                changePortfolioWorkAttribute={changePortfolioWorkAttribute}
              />
            ))}
          </Row>}
        </div>
        {!showWorks &&
        <div className="row">
          <div className="col-lg-8 offset-lg-4">
            <div className="main-hint in-grey-400 m-b-20">
              <i className="main-hint__icon icon-info-circle"/>
              <p className="main-hint__text in-grey-200">
                First, please, set your experience in this category. Then upload 4 examples of your best work for this
                category. Your portfolio will be vetted by our team and you will receive an answer by email as soon as
                we
                can. This can take some time; we get a lot of good portfolios. Please bear with us in the meantime!
              </p>
            </div>
          </div>
        </div>
        }
      </div>
    </div>
  )
}

export default DesignerSettingsExperienceSection
