import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const Row = ({ children, className, columnClass }) => (
  <div className={classNames('row', className)}>
    {children && children.map
      ? children.map((c, i) => <div key={i} className={columnClass}>{c}</div>)
      : children
    }
  </div>
)

Row.propTypes = {
  children: PropTypes.node,
  columnClass: PropTypes.string
}

export default Row
