import React, { useState } from 'react'
import { useSelector } from 'react-redux'
import cn from 'classnames'
import { Modal } from 'semantic-ui-react'

import Button from '../Button'
import Headline from '../Headline'

import { brandsSelector } from '@selectors/brands'
import { setBrandBackgroundColors } from '@utils/brandBackgroundColors'

import styles from './SelectBrandModal.module.scss'

const BrandTile = ({ brand, isSelected, index, onClick }) => {
  const handleClick = () => onClick(brand.name || '')

  return (
    <div className={styles.brandTileWrapper}>
      <div
        className={cn(styles.brandTile, { [styles.selected]: isSelected })}
        style={setBrandBackgroundColors(brand.logo, index)}
        onClick={handleClick}
      >
        {isSelected && (
          <div className={styles.tick} />
        )}

        {!brand.logo && (
          <div className={styles.brandName}>
            {brand.name}
          </div>
        )}
      </div>
    </div>
  )
}

const NewBrandTile = ({ isSelected, onClick }) => {
  const handleClick = () => onClick('')

  return (
    <div className={styles.brandTileWrapper}>
      <div
        className={cn(styles.brandTile, styles.newBrandTile, { [styles.selected]: isSelected })}
        onClick={handleClick}
      >
        {isSelected && (
          <div className={styles.tick}/>
        )}

        <div className={styles.plusWrapper}>
          <div className={styles.plus}>+</div>
          <div className={styles.newBrandLabel}>Create<br/>new brand</div>
        </div>
      </div>
    </div>
  )
}

const SelectBrandModal = ({ brandName, onChange }) => {
  const [open, setOpen] = useState(false)

  const handleOpen = () => setOpen(true)
  const handleClose = () => setOpen(false)

  const brands = useSelector(brandsSelector)

  return (
    <Modal
      size="small"
      onClose={handleClose}
      onOpen={handleOpen}
      open={open}
      className={styles.modal}
      trigger={<span className={styles.switchBtn}>switch brand</span>}
    >
      <div className={cn('icon-cross', styles.closeIcon)} onClick={handleClose} />

      <Modal.Content className={styles.modalContent}>
        <Headline>Select your brand below</Headline>

        <div className={styles.brandsList}>
          {brands.map((brand, index) => (
            <BrandTile
              key={index}
              index={index}
              brand={brand}
              isSelected={brandName && brandName === brand.name}
              onClick={onChange}
            />
          ))}

          <NewBrandTile
            isSelected={!brandName}
            onClick={onChange}
          />
        </div>

        <div className={styles.modalFooter}>
          <Button onClick={handleClose}>Continue →</Button>
        </div>
      </Modal.Content>
    </Modal>
  )
}

export default SelectBrandModal
