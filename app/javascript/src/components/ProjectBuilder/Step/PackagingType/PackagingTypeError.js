import React from 'react'
import PropTypes from 'prop-types'
import { Field } from 'react-redux-form'

const PackagingTypeErrorText = ({ text }) => (
  <div className="in-pink-500">
    {text}
  </div>
)

PackagingTypeErrorText.propTypes = {
  text: PropTypes.string.isRequired
}

const PackagingTypeError = ({ model, text }) => (
  <Field model={model}>
    {({ valid, submitFailed }) => {
      if (!valid && submitFailed) {
        return (<PackagingTypeErrorText
          text={text}
        />)
      }
    }}
  </Field>
)

PackagingTypeError.propTypes = {
  text: PropTypes.string.isRequired,
  model: PropTypes.string.isRequired
}

export default PackagingTypeError
