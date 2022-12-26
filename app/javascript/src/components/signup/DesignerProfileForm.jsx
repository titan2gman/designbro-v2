import _ from 'lodash'
import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { withRouter } from 'react-router-dom'

import Row from '../inputs/Row'
import LabelInput from '../inputs/LabelInput'
import MaterialInput from '../inputs/MaterialInputPlain'
import MaterialSelect from '../inputs/MaterialSelectPlain'
import MaterialCountryInput from '../inputs/MaterialCountryInputPlain'
import SignupLimitedFunctionalityModal from './LimitedFunctionalityModal'
import { genderOptions, englishOptions, designExperienceOptions, monthOfBirthOptions } from '@constants'

const hasNoDesignExperience = ({ experiences }) => {
  return _.every(experiences, (e) => e.experience === 'no_experience')
}

const hasNoEnglishExperience = ({ experienceEnglish }) => {
  return experienceEnglish === 'not_good_english'
}

const modalTexts = {
  design: 'You mentioned you have \'no experience\'. That means that you will not be able to use our platform, as we currently only offer our clients experienced designers. You can come back if you made a mistake or once you have a bit more experience.',
  english: 'Sorry DesignBro is currently only available for designers who read & write in English. Feel free to check back later.'
}

class DesignerRegistrationProfileForm extends Component {
  state = {}

  submit = (e) => {
    e.preventDefault()

    const redirectCallback = () => {
      this.props.history.push('/d/signup/portfolio')
    }

    if (hasNoEnglishExperience(this.props.attributes)) {
      this.setState({
        modalText: modalTexts['english']
      })
    } else if (hasNoDesignExperience(this.props.attributes)) {
      this.setState({
        modalText: modalTexts['design']
      })
    } else {
      this.props.saveProfileAttributes(redirectCallback)
    }
  }

  closeModal = () => {
    this.setState({
      modalText: null
    })
  }

  render () {
    const {
      attributes,
      errors,
      productCategories,
      changeProfileAttribute,
      changeProfileExperience
    } = this.props

    return (
      <form className="col-lg-6" onSubmit={this.submit}>
        <section className="join-profile-info__group">
          <MaterialInput
            label="Displayed username"
            type="text"
            name="displayName"
            autoComplete="username"
            value={attributes.displayName}
            onChange={changeProfileAttribute}
            error={errors.displayName}
          />

          <Row columnClass="col-lg-6">
            <MaterialInput
              label="First Name"
              type="text"
              name="firstName"
              autoComplete="firstName"
              value={attributes.firstName}
              onChange={changeProfileAttribute}
              error={errors.firstName}
            />
            <MaterialInput
              label="Last Name"
              type="text"
              name="lastName"
              autoComplete="lastName"
              value={attributes.lastName}
              onChange={changeProfileAttribute}
              error={errors.lastName}
            />
          </Row>

          <MaterialCountryInput
            name="countryCode"
            value={attributes.countryCode}
            onChange={changeProfileAttribute}
            error={errors.countryCode}
          />

          <Row columnClass="col-xs-4 col-lg-4">
            <MaterialSelect
              name="dateOfBirthMonth"
              placeholder="Month of Birth"
              options={monthOfBirthOptions}
              value={attributes.dateOfBirthMonth || null}
              onChange={changeProfileAttribute}
              error={errors.dateOfBirthMonth}
            />
            <MaterialInput
              label="Day of Birth"
              name="dateOfBirthDay"
              type="number"
              value={attributes.dateOfBirthDay}
              onChange={changeProfileAttribute}
              error={errors.dateOfBirthDay}
            />
            <MaterialInput
              label="Year of Birth"
              name="dateOfBirthYear"
              type="number"
              value={attributes.dateOfBirthYear}
              onChange={changeProfileAttribute}
              error={errors.dateOfBirthYear}
            />
          </Row>

          <MaterialSelect
            name="gender"
            options={genderOptions}
            value={attributes.gender}
            onChange={changeProfileAttribute}
            error={errors.gender}
            placeholder="Gender"
          />

          <MaterialInput
            label="Online portfolio"
            type="text"
            name="onlinePortfolio"
            value={attributes.onlinePortfolio}
            onChange={changeProfileAttribute}
            error={errors.onlinePortfolio}
          />
        </section>

        <section className="join-profile-info__group">
          <h2 className="join-profile-info__form-title">Please set your experience</h2>

          {_.map(productCategories, (category) => {

            const experience = _.find(attributes.experiences, (e) => {
              return e.product_category_id.toString() === category.id
            })

            return (
              <LabelInput label={category.fullName}>
                <MaterialSelect
                  name={category.id}
                  options={designExperienceOptions}
                  value={experience && experience.experience}
                  onChange={changeProfileExperience}
                  placeholder="Set your experience"
                />
              </LabelInput>
            )
          })}

          <LabelInput label="Written English level">
            <MaterialSelect
              name="experienceEnglish"
              options={englishOptions}
              value={attributes.experienceEnglish}
              onChange={changeProfileAttribute}
              placeholder="Set your experience"
              error={errors.experienceEnglish}
            />
          </LabelInput>
        </section>

        <SignupLimitedFunctionalityModal
          isOpen={!!this.state.modalText}
          onClose={this.closeModal}
          text={this.state.modalText}
        />

        <button
          className="main-button main-button--lg font-16 main-button--pink-black m-b-30"
          type="submit"
        >
          Next Step
          <i className="icon-arrow-right-long align-middle m-l-20 font-8" />
        </button>
      </form>
    )
  }
}

DesignerRegistrationProfileForm.propTypes = {
  onSubmit: PropTypes.func.isRequired,
  onSuccess: PropTypes.func.isRequired,
  onError: PropTypes.func.isRequired
}

export default withRouter(DesignerRegistrationProfileForm)
