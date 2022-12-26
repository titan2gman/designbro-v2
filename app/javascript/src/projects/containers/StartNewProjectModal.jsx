import map from 'lodash/map'

import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { connect } from 'react-redux'
import { Modal } from 'semantic-ui-react'
import { withRouter } from 'react-router-dom'

import { hideModal } from '@actions/modal'

import { getFeaturedImage } from '@selectors/featuredImage'
import { humanizeProjectTypeName } from '@utils/humanizer'

const SOCIAL_NETWORKS = {
  fb: 'https://fb.me/designbrocom',
  twitter: 'https://twitter.com/designbrodotcom',
  instagram: 'https://www.instagram.com/designbrodotcom',
  pinterest: 'https://www.pinterest.com/designbrodotcom'
}

const ShareButtonBar = ({ spotUrl }) => (
  <div className="modal-primary__body">
    <div className="dpj-file__modal-info pjsumm-general-info">
      <div
        className="dpj-file__modal-info-photo pjsumm-general-info__photo"
        style={{ backgroundImage: `url(${spotUrl})` }}
      />
      <div className="dpj-file__modal-description dpj-file__modal-part-small">
        <div className="container">
          <p className="dpj-file__modal-description-title font-16">
            Share Your New Design With Your Friends
          </p>

          {map(SOCIAL_NETWORKS, (value, key) => (
            <a
              href={value}
              key={key}
              className="inline-block main-button-link--grey-pink m-r-15"
              target="_blank"
            >
              <i className={`icon-${key}-circle font-40`} />
            </a>
          ))}
        </div>
      </div>
    </div>
  </div>
)

const StartNewProjectModal = ({ project: { productKey }, onClose, className, spotUrl, history }) => {

  const handleClick = () => {
    onClose()
    history.push('/c')
  }

  return (
    <Modal onClose={onClose} className={classNames('main-modal main-modal--xs', className)} size="small" open>
      <div className="modal-primary">
        <div className="modal-primary__header bg-grey-100 text-center">
          <p className="dpj-file__modal-header-title modal-primary__header-title">
            Congrats on your new {humanizeProjectTypeName(productKey)}!
          </p>
          <button
            className="main-button main-button--clear-black main-button--md m-b-10"
            onClick={handleClick}
          >
            Go to dashboard
          </button>
        </div>

        <ShareButtonBar spotUrl={spotUrl} />
      </div>
    </Modal>
  )
}

StartNewProjectModal.propTypes = {
  onClose: PropTypes.func.isRequired,
  spotUrl: PropTypes.string.isRequired,

  project: PropTypes.shape({
    productKey: PropTypes.string.isRequired
  }).isRequired
}

const mapStateToProps = (state) => ({
  spotUrl: getFeaturedImage(state).url
})

const mapDispatchToProps = {
  onClose: hideModal
}

export default connect(mapStateToProps, mapDispatchToProps)(
  withRouter(StartNewProjectModal)
)
