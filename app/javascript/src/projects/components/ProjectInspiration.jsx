import React from 'react'
import ContentEditable from 'react-contenteditable'

export default ({ inspirations }) => (
  <div className="brief-section">
    <p className="brief-section__title">Inspiration</p>
    <div className="row m-b-30">

      {inspirations.map((image) => (
        <div key={image.id} className="brief__photo-big col-xs-12 col-lg-4 m-b-20">
          <img src={image.url} alt="inspiration" />
          {image.comment && <span>
            <p className="brief__title--sm">Comment</p>
            <p className="brief__comment-text" >
              <ContentEditable html={image.comment} disabled />
            </p>
          </span>}
        </div>
      ))}

    </div>
  </div>
)
