import React, { forwardRef } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import ErrorMessage from '../ErrorMessage'
import styles from './Checkbox.module.scss'

const Checkbox = forwardRef(({ classes, error, label, ...inputOptions }, ref) => {
  return (
    <div className={classNames(styles.root, classes.root)}>
      <label className={classNames(styles.label, classes.label)}>
        <input
          className={classNames(styles.input, classes.input)}
          type="checkbox"
          {...inputOptions}
          ref={ref}
        />

        <span className={classNames(styles.icon, classes.icon)} />

        <span className={classNames(styles.text, classes.text)} >
          {label}
        </span>
      </label>

      <ErrorMessage error={error} className={classes.error} />
    </div>
  )
})

Checkbox.propTypes = {
  label: PropTypes.string.isRequired,
  classes: PropTypes.shape({
    error: PropTypes.string,
    icon: PropTypes.string,
    input: PropTypes.string,
    label: PropTypes.string,
    text: PropTypes.string,
    root: PropTypes.string
  })
}

Checkbox.defaultProps = {
  classes: {}
}

export default Checkbox
