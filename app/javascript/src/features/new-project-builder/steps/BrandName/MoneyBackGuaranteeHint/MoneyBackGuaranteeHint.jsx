import React from 'react'

import MoneyBackGuaranteeModal from '../../../components/MoneyBackGuaranteeModal'

import styles from './MoneyBackGuaranteeHint.module.scss'

const MoneyBackGuaranteeHint = () => (
  <MoneyBackGuaranteeModal
    trigger={<span className={styles.moneyBack} />}
  />
)

export default MoneyBackGuaranteeHint
