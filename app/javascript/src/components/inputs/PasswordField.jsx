import capitalize from 'lodash/capitalize'

import PropTypes from 'prop-types'
import classNames from 'classnames'
import React, { Component } from 'react'

import scorePassword from '@utils/scorePassword'

import MaterialInput from '@components/inputs/MaterialInput'

function getLevel (score) {
  if (score > 60) {
    return 'strong'
  } else if (score > 25) {
    return 'fair'
  }

  return 'weak'
}

const StatusLine = ({ score }) => {
  const level = getLevel(score)
  return (
    <div>
      <span className="main-input__strength-type">{capitalize(level)} Pass</span>
      <span className="main-input__strength-line">
        <span className={classNames('main-input__strength-line-bg', level)} />
      </span>
    </div>
  )
}

class PasswordField extends Component {
  state = { present: false, score: 0 }

  handleChange (value) {
    this.setState({ present: !!value.length, score: scorePassword(value) })
  }

  render () {
    const { present, score } = this.state
    return (
      <MaterialInput {...this.props} updateOn="change" onChange={(e) => { this.handleChange(e.target.value) }}>
        {present && <StatusLine score={score} />}
      </MaterialInput>
    )
  }
}

PasswordField.propTypes = {
  type: PropTypes.string.isRequired,
  id: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  autoComplete: PropTypes.string,
  hasError: PropTypes.bool,
  error: PropTypes.string
}

export default PasswordField
