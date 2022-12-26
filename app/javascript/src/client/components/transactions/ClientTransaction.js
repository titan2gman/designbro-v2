import React from 'react'
import moment from 'moment'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'

const ClientTransaction = ({ payment: { projectId, projectName, paymentId, createdAt }, downloadUrl }) => (
  <div className="table-row-item">
    <div className="table-row-item__cell">
      <p className="table-row-item__cell-date">
        {moment(createdAt).format('DD / MM / YYYY')}
      </p>
    </div>
    <div className="table-row-item__cell table-row-item__info">
      <div className="table-row-item__info-block table-row-item__description">
        <Link to={`/c/projects/${projectId}`} className="table-row-item__text table-row-item__text-link text-underline">
          {projectName}
        </Link>
      </div>
      <div className="table-row-item__info-block hidden-sm-down">
        <p className="in-green-500 font-bold">
          {paymentId.slice(0, 6)}
        </p>
      </div>
      <div className="table-row-item__info-block">
        <a download href={downloadUrl} className="table-row-item__text-link table-row-item__status hidden-sm-down">
          <span className="table-row-item__text">Download Receipt</span>
          <i className="icon-download table-row-item__icon" />
        </a>
      </div>
    </div>
  </div>
)

ClientTransaction.propTypes = {
  payment: PropTypes.shape({
    projectId: PropTypes.number.isRequired,
    paymentId: PropTypes.string.isRequired,
    createdAt: PropTypes.string.isRequired,
    projectName: PropTypes.string.isRequired
  }).isRequired,

  downloadUrl: PropTypes.string.isRequired
}

export default ClientTransaction
