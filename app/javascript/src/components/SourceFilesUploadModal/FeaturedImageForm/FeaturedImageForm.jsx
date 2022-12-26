import React from 'react'
import PropTypes from 'prop-types'
import useForm from 'react-hook-form'
import classNames from 'classnames'
import _ from 'lodash'
import { Popup } from 'semantic-ui-react'

import FormButtonWrapper from '@components/FormButtonWrapper'
import FormButton from '@components/FormButton'
import FeaturedImageUploader from '../../FeaturedImageUploader'
import styles from './FeaturedImageForm.module.scss'

const FeaturedImageForm = ({ canContinue, onSubmit }) => {
  const { register, handleSubmit, setValue, errors } = useForm()

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div className={styles.subheader}>
        Set the featured image for the winning design
        <Popup
          content="The featured image should be a clear representation of the winning design. It will be shown in your portfolio on DesignBro as well as on the client's brand overview page."
          position="right center"
          size="mini"
          trigger={<i className={classNames('icon-info-circle', styles.infoIcon)} />}
        />
      </div>

      <div className={styles.warning}>
        NOTE: The featured image must be in a square shaped JPG format.
      </div>

      <FeaturedImageUploader />

      <FormButtonWrapper>
        <FormButton
          type="submit"
          className={classNames({ active: canContinue })}
          disabled={!canContinue}
        >
          Confirm & continue &#8594;
        </FormButton>
      </FormButtonWrapper>

    </form>
  )
}

export default FeaturedImageForm
