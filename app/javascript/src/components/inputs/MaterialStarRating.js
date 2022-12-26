import React from 'react'
import Rating from 'react-rating'
import PropTypes from 'prop-types'
import { Field } from 'react-redux-form'

import { required } from '@utils/validators'

const RequiredError = () => (
  <div className="main-input__hint in-pink-500 is-visible">
    Required.
  </div>
)

const MaterialStarRating = ({ model, showErrors, onChange, label, className }) => (
  <Field model={model} validators={{ required }}>
    {({ value, submitFailed }) =>
      (<div className={className}>
        <div>
          <p className="font-13 in-grey-200 m-b-10 m-r-15">
            {label}
          </p>

          {submitFailed && value === 0 && showErrors && <RequiredError />}
        </div>

        <Rating
          initialRate={value}
          onChange={onChange(model)}
          full="icon-star in-green-500"
          empty="icon-star in-grey-200" />
      </div>)
    }
  </Field>
)

MaterialStarRating.propTypes = {
  showErrors: PropTypes.bool,
  onChange: PropTypes.func.isRequired,

  model: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.func
  ]).isRequired
}

MaterialStarRating.defaultProps = {
  showErrors: true
}

export default MaterialStarRating
