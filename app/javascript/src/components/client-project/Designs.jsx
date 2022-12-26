import React, { useState, useCallback, useEffect } from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import { Modal } from 'semantic-ui-react'
import _ from 'lodash'
import classNames from 'classnames'

import ClientProjectDesign from '@projects/containers/ClientProjectDesign'
import ClientDirectConversationView from '../../views/ClientDirectConversationView'
import ImageModal from '@components/ImageModal'
import styles from './Designs.module.scss'

const Designs = ({
  project,
  winnerSpot,
  designIdParam,

  visibleSpots,
  finalistSpots,
  inProgressSpots,

  isSpotsVisible,
  isFinalistsTabVisible,
  isInProgressTabVisible,
  isAddSpotVisible,
  addSpotPrice,
  showAdditionalSpotsModal
}) => {
  const [isChatOpen, setIsChatOpen] = useState(false)
  const [imageModalProps, setImageModalProps] = useState({
    isOpen: false,
    imageUrl: null
  })
  const [designId, setDesignId] = useState(null)

  useEffect(() => {
    if (designIdParam) {
      setDesignId(designIdParam)
      setIsChatOpen(true)
    }
  }, [])

  const handleDesignClick = useCallback((spot) => {
    setDesignId(spot.design)
    setIsChatOpen(true)
  })
  const handleChatClose = useCallback(() => {
    setIsChatOpen(false)
  })
  const handleImageModalClose = useCallback(() => {
    setImageModalProps({
      isOpen: false,
      imageUrl: null
    })
  })
  const handleThumbClick = useCallback((_imageModalProps) => {
    setImageModalProps(_imageModalProps)
  })

  return (
    <main>
      <div className="dpj-content__uploaded container">
        <div className="m-b-30">
          {project.projectType === 'contest' ? (
            <>
              {isSpotsVisible && (
                <div className="row">
                  {_.times(project.maxSpotsCount, (index) => visibleSpots[index]).map((spot, index) => (
                    <ClientProjectDesign
                      key={index}
                      spot={spot}
                      index={index}
                      project={project}
                      spotType={'inProgress'}
                      finalists={finalistSpots}
                      onDesignClick={handleDesignClick}
                    />
                  ))}

                  {isAddSpotVisible && (
                    <div className="col-md-4 col-lg-3">
                      <div className={styles.addSpotBtn} onClick={showAdditionalSpotsModal}>
                        <div className={styles.addSpotBtnContent}>
                          <div className={styles.addSpotPlus}>+</div>
                          <div className={styles.addSpotTxt}>Add spot</div>
                          <div className={styles.addSpotPrice}>{addSpotPrice}</div>
                        </div>
                      </div>
                    </div>
                  )}
                </div>
              )}

              {isFinalistsTabVisible && (
                <span>
                  <div className="dpj-status-line">
                    <p className="dpj-status-line__text">Finalists ({finalistSpots.length}/3)</p>
                  </div>

                  <div className="row">
                    {finalistSpots.map((spot, index) => (
                      <ClientProjectDesign
                        key={index}
                        spot={spot}
                        project={project}
                        spotType={'finalist'}
                        index={visibleSpots.indexOf(spot)}
                        onDesignClick={handleDesignClick}
                      />
                    ))}
                  </div>
                </span>
              )}

              {isInProgressTabVisible && (
                <span>
                  <div className="dpj-status-line">
                    <p className="dpj-status-line__text">In Progress</p>
                  </div>

                  <div className="row">
                    {_.times(project.maxSpotsCount - _.size(finalistSpots), (index) => inProgressSpots[index]).map((spot, index) => (
                      <ClientProjectDesign
                        key={index}
                        spot={spot}
                        project={project}
                        spotType={'inProgress'}
                        finalists={finalistSpots}
                        index={spot ? visibleSpots.indexOf(spot) : index + _.size(finalistSpots)}
                        onDesignClick={handleDesignClick}
                      />
                    ))}

                    {isAddSpotVisible && (
                      <div className="col-md-4 col-lg-3">
                        <div className={styles.addSpotBtn} onClick={showAdditionalSpotsModal}>
                          <div className={styles.addSpotBtnContent}>
                            <div className={styles.addSpotPlus}>+</div>
                            <div className={styles.addSpotTxt}>Add spot</div>
                            <div className={styles.addSpotPrice}>{addSpotPrice}</div>
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                </span>
              )}

              {winnerSpot && (
                <span>
                  <div className="dpj-status-line">
                    <p className="dpj-status-line__text">Winner!</p>
                  </div>
                  <div className="row">
                    <ClientProjectDesign
                      spotType="winner"
                      project={project}
                      spot={winnerSpot}
                      index={visibleSpots.indexOf(winnerSpot)}
                      onDesignClick={handleDesignClick}
                    />
                    <div className="col-md-4 col-lg-3">
                      <p className="dpj-content__title">&nbsp;</p>
                      <div className="preview-frame-block">
                        {project.state === 'review_files' && <div className="preview-frame">
                          <div className="preview-frame__content">
                            <p className="preview-frame__text">Please check the uploaded source files here</p>
                            <Link to={`/c/projects/${project.id}/files`} className="in-black">
                              Review files
                              <i className="icon-arrow-right-circle m-l-10 align-middle font-40" />
                            </Link>
                          </div>
                        </div>}
                      </div>
                    </div>
                  </div>
                </span>
              )}
            </>
          ) : (
            <div className="row">
              {_.map(visibleSpots, (spot, index) => (
                <ClientProjectDesign
                  key={index}
                  spot={spot}
                  index={index}
                  project={project}
                  spotType={'inProgress'}
                  finalists={finalistSpots}
                  onDesignClick={handleDesignClick}
                />
              ))}
            </div>
          )}
        </div>
      </div>

      {isChatOpen && <ClientDirectConversationView isOpen={isChatOpen} projectId={project.id} designId={designId} onClose={handleChatClose} onThumbClick={handleThumbClick}/>}
      <ImageModal onClose={handleImageModalClose} isOpen={imageModalProps.isOpen} imageUrl={imageModalProps.imageUrl}/>

    </main>
  )}

Designs.propTypes = {
  project: PropTypes.object.isRequired,
  winnerSpot: PropTypes.object,

  visibleSpots: PropTypes.arrayOf(PropTypes.object).isRequired,
  finalistSpots: PropTypes.arrayOf(PropTypes.object).isRequired,
  inProgressSpots: PropTypes.arrayOf(PropTypes.object).isRequired,

  isSpotsVisible: PropTypes.bool.isRequired,
  isFinalistsTabVisible: PropTypes.bool.isRequired,
  isInProgressTabVisible: PropTypes.bool.isRequired
}

export default Designs
