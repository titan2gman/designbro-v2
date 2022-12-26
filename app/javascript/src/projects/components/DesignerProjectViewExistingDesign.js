import times from 'lodash/times'

import React from 'react'
import PropTypes from 'prop-types'

import { normalizeState } from '@utils/spots'

import Spinner from '@components/Spinner'
import BackgroundImage from '@projects/components/BackgroundImage'

const DesignState = ({ state }) => {
  const processedState = normalizeState(state)

  if (processedState) {
    return (
      <span className="status-indicator in-white bg-black">
        {processedState}
      </span>
    )
  }

  return null
}

const DesignerProjectViewExistingDesign = ({ project, design, spot, loading, showDesignInfo, onDesignClick }) => {
  const onClick = () => {
    onDesignClick(spot)
  }

  return (
    <Spinner loading={loading}>
      {() => (
        <div className="col-md-4 col-lg-3">
          {showDesignInfo &&
            <p className="dpj-content__title">
              {design.name}
            </p>
          }

          <div className="preview-frame-block">
            <BackgroundImage design={design} asLink={showDesignInfo} onClick={onClick}/>

            <div className="text-center">
              {project.projectType === 'contest' && <DesignState state={spot.state} />}

              <p className="dpj-content__uploaded-text">
                <span className="m-r-5">by</span>

                <a className="text-underline in-grey-300 cursor-pointer">
                  {design.designerName}
                </a>
              </p>

              {showDesignInfo &&
                <div className="rating-stars">
                  {times(design.rating, (index) => <i key={index} className="icon-star in-green-500 pointer-events-none" />)}
                  {times(5 - design.rating, (index) => <i key={index} className="icon-star in-grey-200 pointer-events-none" />)}
                </div>
              }
            </div>
          </div>
        </div>
      )}
    </Spinner>
  )
}

DesignerProjectViewExistingDesign.propTypes = {
  design: PropTypes.shape({
    id: PropTypes.string.isRequired,
    name: PropTypes.string.isRequired,
    image: PropTypes.string.isRequired,
    rating: PropTypes.number.isRequired
  }).isRequired,

  spot: PropTypes.shape({
    state: PropTypes.string.isRequired
  }),

  loading: PropTypes.bool.isRequired,
  showDesignInfo: PropTypes.bool.isRequired,
  onDesignClick: PropTypes.func.isRequired
}

export default DesignerProjectViewExistingDesign
