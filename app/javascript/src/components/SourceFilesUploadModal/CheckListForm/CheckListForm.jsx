import React from 'react'
import PropTypes from 'prop-types'
import useForm from 'react-hook-form'
import classNames from 'classnames'
import _ from 'lodash'

import FormButtonWrapper from '@components/FormButtonWrapper'
import FormButton from '@components/FormButton'
import Checkbox from '../../inputs/react-hook-form/Checkbox'
import styles from './CheckListForm.module.scss'

const checkboxes = [
  'No stock images included',
  'No fonts included',
  'I have uploaded both outlined and non-outlined verions',
  'I certify that I\'m the creator of all work',
  'I transfer the copyrights as per the terms & conditions of DesignBro'
]

const CheckListForm = ({ onSubmit }) => {
  const { register, handleSubmit, watch, errors, getValues } = useForm()
  const watchAllFields = watch()
  const values = _.values(getValues())
  const allChecked = values.length > 0 && _.every(values, Boolean)
  const canContinue = allChecked && _.isEmpty(errors)

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      {checkboxes.map((checkboxLabel, index) => {
        const name = `checkbox${index}`

        return (
          <Checkbox
            classes={{
              root: styles.checkboxRoot,
              icon: styles.checkboxIcon,
              error: styles.checkboxError,
            }}
            key={index}
            name={name}
            label={checkboxLabel}
            ref={register({ required: 'Required' })}
            error={errors[name]}
          />
        )
      })}

      <FormButtonWrapper>
        <FormButton
          type="submit"
          className={classNames({ active: canContinue })}
          disabled={!canContinue}
        >
          Next &#8594;
        </FormButton>
      </FormButtonWrapper>
    </form>
  )
}

CheckListForm.propTypes = {
  onSubmit: PropTypes.func.isRequired
}

export default CheckListForm
