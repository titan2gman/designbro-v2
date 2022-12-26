import React from 'react'
import classNames from 'classnames'

//styles
import styles from './Testimonial.module.scss'

export const Testimonial = ({ rating }) => {
  return (
    <div className={styles.detailsTestimonial}>
      <p className={styles.title}>Excellent</p>
      <p className={styles.text}>
        DesignBro is excellent, fully trustworthy and delivers a great service.
        We were extremely happy with what we got in terms of product and
        customer service.
      </p>
      <p className={styles.author}>
        <span className={classNames(styles.stars, styles.filled)}>
          {'★'.repeat(rating)}
        </span>
        <span className={styles.stars}>
          {'★'.repeat(5 - rating)}
        </span>
        Kristin Gonzalez - Warrior Shack
      </p>
    </div>
  )
}

Testimonial.defaultProps = {
  rating: 5
}
