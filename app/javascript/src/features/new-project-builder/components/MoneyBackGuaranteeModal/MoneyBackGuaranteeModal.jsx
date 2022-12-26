import React, { useState } from 'react'
import cn from 'classnames'
import { Modal } from 'semantic-ui-react'

import Headline from '../Headline'
import Button from '../Button'

import styles from './MoneyBackGuaranteeModal.module.scss'

const MoneyBackGuaranteeModal = ({ trigger }) => {
  const [open, setOpen] = useState(false)

  const handleOpen = () => setOpen(true)
  const handleClose = () => setOpen(false)

  return (
    <Modal
      size="small"
      onClose={handleClose}
      onOpen={handleOpen}
      open={open}
      className={styles.modal}
      trigger={trigger}
    >
      <div className={cn('icon-cross', styles.closeIcon)} onClick={handleClose} />

      <Modal.Content className={styles.modalContent}>
        <p className={styles.headline}>Refund policy</p>

        <br/>

        <p>First of all we would like to note that customer satisfaction is a very high priority at DesignBro. We value our customers, and want to deliver you the design you’ll love. Contact us prior to considering a refund, as we can help in almost all cases.</p>

        <br/>

        <p className={styles.headline}>The Client can be given a refund in these cases:</p>

        <ul className={styles.ul}>
          <li className={styles.li}>If there was a disregard for the briefing by the designers (this is at DesignBro’s discretion)</li>
          <li className={styles.li}>If there were less designs submitted (including eliminated) during the design stage than paid for</li>
          <li className={styles.li}>When the client is unsatisfied with the works delivered and requests the refund to the DesignBro team no later than 5 days into the design stage</li>
        </ul>

        <p className={styles.headline}>The Client forfeits any refund if:</p>

        <ul className={styles.ul}>
          <li className={styles.li}>Client selects a finalist</li>
          <li className={styles.li}>Client mentions to a designer they will work with designer / pick designer as a finalist / select designer as a winner</li>
          <li className={styles.li}>Client approaches the designer to work off-platform</li>
          <li className={styles.li}>Client gives a star-rating of 4 or higher to any design</li>
          <li className={styles.li}>Client has not given any feedback to any designers</li>
          <li className={styles.li}>Client has not contacted support at least once during the design stage to try to see if they can help with their particular problem</li>
          <li className={styles.li}>Client has allowed the project to timeout</li>
          <li className={styles.li}>The reason is that Client no longer has a need for the project</li>
          <li className={styles.li}>The Client launched the same project simultaneously elsewhere</li>
        </ul>

        <p>All refunds are at the discretion of the Support Executive at DesignBro.</p>

        <p>When Client opts for a money back guarantee- Client will not be able to use (in any way shape or form) any of the designs presented.</p>

        <p>DesignBro cannot issue a refund on any NDA agreements.</p>

        <p>DesignBro cannot issue refunds on any extra time purchased.</p>

        <p>DesignBro charges a one-time administration fee of $20 to process the refund (this will be deducted from the receivable).</p>
      </Modal.Content>
    </Modal>
  )
}

export default MoneyBackGuaranteeModal
