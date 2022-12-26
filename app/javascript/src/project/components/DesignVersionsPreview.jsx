import partial from 'lodash/partial'

import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Spinner from '@components/Spinner'

const PreviousVersion = ({ image, active, onClick, index, onPreviousDesignHover }) => (
  <div className="previous-version">
    <div
      className={`preview__thumbnail ${active ? 'preview__thumbnail-active' : ''}`}
      style={{ backgroundImage: `url("${image}")` }}
      onClick={onClick}
      onMouseLeave={() => {
        if (!event.target.className.includes('preview__thumbnail-idx')) {
          onPreviousDesignHover({
            show: false
          })}
      }
      }
      onMouseOver={() => {
        if (!event.target.className.includes('preview__thumbnail-idx')) {
          const convContainerRect = document.getElementById('conversation_container').getBoundingClientRect()
          const rect = event.target.getBoundingClientRect()
          const bottom = convContainerRect.height + convContainerRect.top - rect.top + 40
          const left = rect.left - convContainerRect.left
          onPreviousDesignHover({
            show: true,
            containerStyle: {
              left,
              bottom
            },
            imageUrl: image
          })
        }
      }}
    >
      <div className="preview__thumbnail-idx">
        {index}
      </div>
      {active && (
        <div className="preview__thumbnail-check">
          <i className="icon-check preview__thumbnail-check-icon" />
        </div>
      )}
    </div>
  </div>
)

PreviousVersion.propTypes = {
  image: PropTypes.string.isRequired,
  active: PropTypes.bool.isRequired,
}

const DesignVersionsPreview = ({ loading, selected, versions, onClick, userType, onPreviousDesignHover }) => (
  <div className="preview__container">
    <Spinner loading={loading}>
      <div className="preview__content">
        {versions.map((version, index) => (
          userType == 'designer' ?
            <PreviousVersion
              key={index}
              index={versions.length - index}
              image={version.image}
              active={selected === version.id}
              onClick={partial(onClick, version.id)}
              onPreviousDesignHover={onPreviousDesignHover}
            /> :
            <PreviousVersion
              key={index}
              index={versions.length - index}
              image={version.image}
              active={false}
              onPreviousDesignHover={onPreviousDesignHover}
            />
        ))}
      </div>
    </Spinner>
  </div>
)

DesignVersionsPreview.propTypes = {
  loading: PropTypes.bool.isRequired,
  selected: PropTypes.string.isRequired,
  versions: PropTypes.array.isRequired,
  onClick: PropTypes.func.isRequired
}

export default DesignVersionsPreview
