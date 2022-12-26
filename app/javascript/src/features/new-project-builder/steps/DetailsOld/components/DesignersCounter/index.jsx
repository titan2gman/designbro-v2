import React from 'react'

//styles
import styles from './DesignersCounter.module.scss'

const DesignersCounter = ({ minCount, maxCount, value, price, onChange }) => {
  const handleAdd = (event) => {
    event.preventDefault()
    onChange(value + 1)
  }
  const handleSub = (event) => {
    event.preventDefault()
    onChange(value - 1)
  }

  return (
    <>
      <div className={styles.numberWrapper}>
        <button
          className={styles.counterButton}
          disabled={value === minCount}
          onClick={handleSub}
        >
          &#8722;
        </button>

        <p className={styles.counter}>{value}</p>

        <button
          className={styles.counterButton}
          disabled={value === maxCount}
          onClick={handleAdd}
        >
          +
        </button>
      </div>

      <p className={styles.designsPrice}>
        {value <= minCount ? 'Included' : `+ ${price}`}
      </p>
    </>
  )
}

export default DesignersCounter
