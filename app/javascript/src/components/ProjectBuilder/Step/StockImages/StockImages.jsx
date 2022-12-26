import React from 'react'
import PropTypes from 'prop-types'
import Popover from '@terebentina/react-popover'

import { RadioButton, StockImageUploader } from '../../inputs'

const StockImages = ({ productName, stockImagesExist, stockImageUploaders, onChange }) => (
  <div className="bfs-stock-images-block">
    <div className="row">
      <div className="col-md-8">
        <p className="bfs-hint__text">
          Do you already have images or photos you would like to feature on your {productName}?
        </p>
      </div>
    </div>

    <div className="m-b-10">
      <div>
        <label className="main-radio m-r-20">
          <RadioButton
            label="No"
            value="no"
            name={stockImagesExist === 'yes' ? 'stockImagesExist' : 'stockImagesExist2'}
            checked={stockImagesExist !== 'yes'}
            onChange={onChange}
          />
        </label>
      </div>

      {stockImagesExist !== 'yes' && (
        <div className="m-b-10 stock-images-no-subitems">
          <div>
            <label className="main-radio m-r-20">
              <RadioButton
                label="Free only"
                value="free_only"
                name="stockImagesExist"
                onChange={onChange}
              />
            </label>
          </div>

          <div>
            <label className="main-radio m-r-20">
              <RadioButton
                label="Free & paid (expect to pay +/- $50 per photo)"
                value="free_and_paid"
                name="stockImagesExist"
                onChange={onChange}
              >
                <Popover trigger={<i className="icon-info-circle" />} position="right">
                  <p>
                    Our designers would be more than happy to help you find professional images that fit your brand from free or paid resources. For the paid resources they would look at large stock photography websites. They will be able to provide you with a cost indication and once you approve an image they will send you a link and you will be able to buy the image directly from the supplier. DesignBro or the designers are not affiliated with these third parties and do not earn a commission on these purchases.
                  </p>
                </Popover>
              </RadioButton>
            </label>
          </div>

          <div>
            <label className="main-radio m-r-20">
              <RadioButton
                label="I don't want any images or photos"
                value="no"
                name="stockImagesExist"
                onChange={onChange}
              />
            </label>
          </div>
        </div>
      )}

      <div>
        <label className="main-radio">
          <RadioButton
            label="Yes"
            value="yes"
            name="stockImagesExist"
            onChange={onChange}
          />
        </label>
      </div>
    </div>

    {stockImagesExist === 'yes' && (
      <div className="bfs-content__upload-box row">
        {stockImageUploaders.map((uploader, index) => (
          <StockImageUploader
            key={index}
            index={index}
          />
        ))}
      </div>
    )}
  </div>
)

StockImages.propTypes = {
  stockImagesExist: PropTypes.bool.isRequired,
  stockImageUploaders: PropTypes.array
}

export default StockImages
