import isEmpty from 'lodash/isEmpty'
import times from 'lodash/times'
import React, { useState, useCallback, useEffect } from 'react'
import { Link, Redirect, withRouter } from 'react-router-dom'
import PropTypes from 'prop-types'

import Layout from '../../containers/designer-project/Layout'
import UploadButton from '@components/inputs/UploadButton'
import ImageModal from '@components/ImageModal'

import ReserveSpotModalTrigger from '@modals/reserve-spot/containers/ReserveSpotModalTrigger'
import DesignerProjectViewExistingDesign from '@projects/containers/DesignerProjectViewExistingDesign'
import DesignerDirectConversationView from '../../views/DesignerDirectConversationView'

const RESERVE_STATES = ['design_stage']

const Stars = () => (
  <div className="text-center">
    <div className="rating-stars">
      {times(5, (index) => (
        <i key={index} className="icon-star in-grey-200 pointer-events-none" />
      ))}
    </div>
  </div>
)

const AvailableSpot = ({ project }) => (
  <div className="col-md-4 col-lg-3">
    <p className="dpj-content__title">Available spot</p>

    <div className="preview-frame-block">
      <div className="preview-frame bg-grey-100">
        <div className="preview-frame__content space-between">
          <p className="preview-frame__text">
            Hey! There is another spot available in this competition. Do you
            want to make another design?
          </p>

          <ReserveSpotModalTrigger project={project} />
        </div>
      </div>

      <Stars />
    </div>
  </div>
)

const OneMoreDesign = ({ onUpload }) => (
  <div className="col-md-4 col-lg-3">
    <p className="dpj-content__title">&nbsp;</p>
    <div className="preview-frame-block">
      <div className="preview-frame bg-grey-100">
        <div className="preview-frame__content space-between">
          <p className="preview-frame__text">Upload a new design</p>
          <UploadButton onUpload={onUpload}>
            <a className="in-black">
              Submit Design
              <i className="icon-arrow-right-circle m-l-10 align-middle font-40" />
            </a>
          </UploadButton>
        </div>
      </div>
      <Stars />
    </div>
  </div>
)

const ProjectDesigns = ({ me, winner, mySpot, project, designs, match, history, uploadDesign, designIdParam }) => {
  const projectId = match.params.id
  const [isChatOpen, setIsChatOpen] = useState(false)
  const [designId, setDesignId] = useState(null)
  const [imageModalProps, setImageModalProps] = useState({
    isOpen: false,
    imageUrl: null
  })

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
  const handleUpload = (file) => {
    uploadDesign(file, projectId, ({ payload }) => {
      const designId = payload.results.designs[0]
      setDesignId(designId)
      setIsChatOpen(true)
    })
  }

  return (
    isEmpty(mySpot) ?
      <Redirect to={`/d/projects/${projectId}`} />
      :
      <Layout page="designs" handleUpload={handleUpload}>
        <div className="bg-grey-10">
          {isEmpty(designs) && (
            <div className="dpj-content-empty container text-center">
              <img
                alt="empty"
                src="/empty_page.png"
                srcSet="/empty_page_2x.png 2x"
                className="dpj-content-empty__img m-b-30"
              />

              {project.projectType === 'one_to_one' ? (
                <>
                  <p className="dpj-content-empty__text">
                    Don't Lose Your Project!
                  </p>

                  <div className="flex justify-center">
                    <UploadButton
                      onUpload={handleUpload}
                      className="upload-files"
                    >
                      <span className="text-underline in-black cursor-pointer">
                        Upload it here
                      </span>
                    </UploadButton>
                  </div>
                </>
              ) : mySpot.hoursToExpire > 0 ? (
                <>
                  <p className="dpj-content-empty__text">
                    Don't Lose Your Spot!
                    <br />
                    You have {mySpot.hoursToExpire} hours left to upload your
                    design before your reservation expires.
                  </p>

                  <div className="flex justify-center">
                    <UploadButton
                      onUpload={handleUpload}
                      className="upload-files"
                    >
                      <span className="text-underline in-black cursor-pointer">
                        Upload it here
                      </span>
                    </UploadButton>
                  </div>
                </>
              ) : (
                <>
                  <p className="dpj-content-empty__text">
                    Your spot reservation expired.
                    <br />
                    Please return to the project to reserve a spot.
                  </p>

                  <div className="flex justify-center">
                    <Link
                      to={`/d/projects/${project.id}`}
                      className="main-button main-button--md main-button--black-pink font-12"
                    >
                      Go to Brief
                    </Link>
                  </div>
                </>
              )}
            </div>
          )}

          {!isEmpty(designs) && (
            <div className="dpj-content__uploaded container">
              <div className="row">
                {winner && (
                  <DesignerProjectViewExistingDesign
                    design={winner}
                    project={project}
                    onDesignClick={handleDesignClick}
                  />
                )}

                {!winner &&
                  designs.map((design, index) => (
                    <DesignerProjectViewExistingDesign
                      key={index}
                      design={design}
                      project={project}
                      onDesignClick={handleDesignClick}
                    />
                  ))}

                {project.projectType === 'contest' &&
                  RESERVE_STATES.includes(project.state) &&
                  !winner &&
                  project.mySpotsCount === 2 &&
                  designs.length < 2 && (
                  <OneMoreDesign onUpload={handleUpload} />
                )}
                {project.projectType === 'contest' &&
                  RESERVE_STATES.includes(project.state) &&
                  !winner &&
                  project.mySpotsCount === 1 &&
                  designs.length === 1 && <AvailableSpot project={project} />}
              </div>
            </div>
          )}
        </div>
        {isChatOpen && <DesignerDirectConversationView projectId={project.id} designId={designId} onClose={handleChatClose} onThumbClick={handleThumbClick}/>}
        <ImageModal onClose={handleImageModalClose} isOpen={imageModalProps.isOpen} imageUrl={imageModalProps.imageUrl}/>
      </Layout>
  )
}

ProjectDesigns.propTypes = {
  winner: PropTypes.object,
  mySpot: PropTypes.object,
  project: PropTypes.object,
  me: PropTypes.object.isRequired,
  uploadDesign: PropTypes.func.isRequired,
  reserveSpot: PropTypes.func.isRequired,
  designs: PropTypes.arrayOf(PropTypes.object),
}

export default withRouter(ProjectDesigns)
