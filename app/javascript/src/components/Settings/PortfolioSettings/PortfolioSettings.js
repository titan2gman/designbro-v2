import React from 'react'
import classNames from 'classnames'
import Popover from '@terebentina/react-popover'
import styles from './PortfolioSettings.module.scss'
import AvailableRadioButton from './AvailableRadioButton'
import LanguagesSelect from './LanguagesSelectContainer'
import Input from './InputContainer'
import ImageDropzone from './ImageDropzoneContainer'

const PortfolioSettings = ({ attributes }) => {
  return (
    <div>
      <AvailableRadioButton
        name="oneToOneAvailable"
        value={attributes.oneToOneAvailable}
      />

      {attributes.oneToOneAvailable && (
        <>
          <div className="row">
            <div className="col-sm-6 col-md-4 col-xl-3">
              <div className={styles.avatarWrapper}>
                <strong>Upload your avatar</strong>
              </div>

              <ImageDropzone
                name="avatar"
                uploadedFileId={attributes.avatarId}
                previewUrl={attributes.avatarPreviewUrl}
                fileExtensions={['jpg', 'png']}
                fileSize={2}
              />
            </div>

            <div className="col-sm-6 col-md-4 col-xl-3">
              <div className={styles.portfolioImageWrapper}>
                <strong>Upload your portfolio image</strong>
                <Popover trigger={<i className="icon-info-circle" />} position="right">
                  <p>This image will be shown as your hero image on your public portfolio page.</p>
                </Popover>
              </div>

              <ImageDropzone
                name="uploadedHeroImage"
                uploadedFileId={attributes.uploadedHeroImageId}
                previewUrl={attributes.uploadedHeroImagePreviewUrl}
                fileExtensions={['jpg', 'png']}
                fileSize={2}
              />
            </div>
          </div>

          <div className="row">
            <div className="col-sm-12 col-md-6">
              <div className={styles.languagesWrapper} >
                <LanguagesSelect
                  name="languages"
                  placeholder="Languages"
                />
              </div>
            </div>
          </div>

          <div className="row">
            <div className="col-sm-12 col-md-6">
              <div className={styles.descriptionWrapper} >
                <Input
                  name="description"
                  value={attributes.description}
                  label="Tell us about you"
                  maxLength={460}
                  hint="Please write a small text without (max. 460 characters) to introduce yourself to potential clients. Please remember - no last names, portfolio links or any type of contact details."
                />
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  )
}

export default PortfolioSettings
