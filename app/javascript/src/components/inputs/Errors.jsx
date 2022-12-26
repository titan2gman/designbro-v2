import React from 'react'
import { Errors as E } from 'react-redux-form'

const show = (field, form) => field.touched || form.submitFailed

export const ErrorComponent = ({ children }) => <li className="in-pink-500 error">{children}</li>

const Errors = (props) => (
  <E {...props} show={props.show || show} wrapper="ul" component={props.component} />
)

Errors.defaultProps = {
  component: 'li'
}

export default Errors
