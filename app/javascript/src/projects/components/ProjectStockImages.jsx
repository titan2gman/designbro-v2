import React from 'react'
import Popover from '@terebentina/react-popover'
import ContentEditable from 'react-contenteditable'

export default ({ stockImagesExist, stockImages }) => (
  <div className="brief-section" id="stock-images">
    <p className="brief-section__title">
      Images to use
    </p>

    {stockImagesExist === 'free_only' && 'Use free (for commercial use) images only'}

    {stockImagesExist === 'free_and_paid' && (
      <>
        Use free or paid/stock images
        <Popover trigger={<i className="icon-info-circle" />} position="right">
          <p>
            Whenever (paid) stock photos are being used in the design, be sure to supply the client with a link to the image they have to purchase. (Note: you should never purchase the image yourself)
          </p>
        </Popover>
      </>
    )}

    {stockImagesExist === 'no' && 'No images needed'}

    {stockImagesExist === 'yes' && stockImages.map((stockImage) => (
      <span key={stockImage.id}>
        <div className="row m-b-30">
          <div className="brief__photo-big col-xs-12 col-lg-3">
            <img src={stockImage.url} alt="existing logo" />
          </div>
        </div>

        {stockImage.comment && <span>
          <p className="brief__title--sm">Comment</p>
          <p className="brief__comment-text">
            <ContentEditable html={stockImage.comment} disabled />
          </p>
        </span>}
      </span>
    ))}
  </div>
)
