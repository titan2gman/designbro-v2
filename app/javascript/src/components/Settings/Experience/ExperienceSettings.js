import _ from 'lodash'
import React, { Component } from 'react'
import ExperienceSettingsSection from './ExperienceSettingsSection'
import ExperienceSettingsHeader from './ExperienceSettingsHeader'

class ExperienceSettingsForm extends Component {
  handleSubmit = (e) => {
    e.preventDefault()
    this.props.submitExperienceSettings()
  }

  render() {
    const {
      attributes,
      initialExperiences,
      validation,
      productCategories,
      uploadPortfolioFile,
      changePortfolioWorkAttribute,
      changeProfileExperience,
      works,
    } = this.props

    return (
      <form onSubmit={this.handleSubmit}>
        <ExperienceSettingsHeader />

        {_.map(productCategories, (category) => {

          const experience = _.find(attributes.experiences, (e) => {
            return e.product_category_id.toString() === category.id
          })
          const initialExperience = _.find(initialExperiences, (e) => {
            return e.product_category_id.toString() === category.id
          })

          return (
            <ExperienceSettingsSection
              works={works[category.id]}
              category={category}
              initialExperience={initialExperience}
              changePortfolioWorkAttribute={changePortfolioWorkAttribute}
              uploadPortfolioFile={uploadPortfolioFile}
              changeProfileExperience={changeProfileExperience}
              experience={experience}
              validation={_.get(validation, [category.id], {})}
            />
          )
        })}

        <button
          className="main-button main-button--lg font-16 main-button--pink-black m-b-30"
          type="submit"
        >
          Submit
          <i className="icon-arrow-right-long align-middle m-l-20 font-8"/>
        </button>
      </form>
    )
  }
}

export default ExperienceSettingsForm
