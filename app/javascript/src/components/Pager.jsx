import React from 'react'
import PropTypes from 'prop-types'
import segmentize from 'segmentize'
import classNames from 'classnames'

const NumberButton = ({ active, page, onClick }) => (
  <button
    className={classNames('page-nav__item page-nav__item-number', { 'page-nav__item--active': active })}
    type="button"
    onClick={(e) => { e.preventDefault(); onClick(page) }}>
    {page}
  </button>
)

const ArrowButton = ({ page, disabled, onClick, children }) => (
  <button
    className="page-nav__item page-nav__item-arrow"
    disabled={disabled}
    type="button"
    onClick={(e) => { e.preventDefault(); onClick(page) }}>
    {children}
  </button>
)

const showEllipsis = (prev, next) => prev && next && prev.slice(-1)[0] + 1 < next[0]
const Ellipsis = ({ prev, next }) => {
  if (showEllipsis(prev, next)) {
    return <span className="page-nav__item page-nav__item-dots">&#8230;</span>
  }

  return false
}

const Pager = ({ current, total, className, onClick }) => {
  const { beginPages, previousPages, centerPage, nextPages, endPages } = segmentize({
    page: current,
    pages: total,
    sidePages: 2,
    beginPages: 1,
    endPages: 1
  })

  if (total < 2) {
    return false
  }

  return (
    <nav className={classNames('page-nav', className)}>
      <ArrowButton page={current - 1} disabled={current < 2} onClick={onClick}>
        <i className="icon-arrow-left" />
      </ArrowButton>
      {beginPages.map((p) => <NumberButton key={p} page={p} onClick={onClick} />)}
      <Ellipsis prev={beginPages} next={previousPages} onClick={onClick} />
      {previousPages.map((p) => <NumberButton key={p} page={p} onClick={onClick} />)}
      {centerPage.map((p) => <NumberButton key={p} page={p} onClick={() => {}} active />)}
      {nextPages.map((p) => <NumberButton key={p} page={p} onClick={onClick} />)}
      <Ellipsis prev={nextPages} next={endPages} />
      {endPages.map((p) => <NumberButton key={p} page={p} onClick={onClick} />)}
      <ArrowButton page={current + 1} disabled={current > total - 1} onClick={onClick}>
        <i className="icon-arrow-right" />
      </ArrowButton>
    </nav>
  )
}

Pager.propTypes = {
  current: PropTypes.number.isRequired,
  total: PropTypes.number.isRequired,
  onClick: PropTypes.func.isRequired,
  className: PropTypes.string
}

export default Pager
