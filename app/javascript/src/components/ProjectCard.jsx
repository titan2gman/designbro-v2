import React from 'react'
import PropTypes from 'prop-types'
import { Link } from 'react-router-dom'
import classNames from 'classnames'

import { cutAt } from '@utils/stringProcessor'

import ProjectCardUserPic from '@containers/ProjectCardUserPic'
import ProjectTime from '@containers/ProjectTime'
import Status from '@components/ProjectStatus'

const DetailsGroup = ({ children }) => (
  <ul className="project-details">
    {children}
  </ul>
)
DetailsGroup.propTypes = {
  children: PropTypes.node
}

const DetailsItem = ({ icon, stats, hint }) => (
  <li className="project-detail">
    <i className={classNames('project-detail__icon icon', icon)} />
    <span className="project-detail__number">
      {stats}
    </span>

    <span className="project-detail__text">
      {hint}
    </span>
  </li>
)

DetailsItem.propTypes = {
  icon: PropTypes.string.isRequired,
  hint: PropTypes.string.isRequired,

  stats: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]).isRequired
}

const Icon = ({ type }) => {
  return (
    <img
      src={`/projects/${type}.svg`}
      className="project-card__type-image"
    />
  )
}

Icon.propTypes = {
  type: PropTypes.string.isRequired
}

const Price = ({ price }) => (
  <p className="project-card__price">
    $ {Math.floor(price)}
  </p>
)

Price.propTypes = {
  price: PropTypes.number.isRequired
}

const Title = ({ name }) => (
  <h2 className="project-card__title">
    {cutAt(name, 36)}
  </h2>
)

Title.propTypes = {
  name: PropTypes.string.isRequired
}

const Footer = ({ children }) => (
  <div className="project-card__footer">
    {children}
  </div>
)

const Content = ({ children }) => (
  <div className="project-card__content word-break">
    <div className="flex-grow">
      {children}
    </div>
  </div>
)

const Description = ({ children }) => (
  <span>{cutAt(children, 160)}</span>
)

const Sidebar = ({ children }) => (
  <div className="project-card__type">
    {children}
  </div>
)

const Activity = ({ children }) => (
  <div>
    <h3 className="project-card__title-secondary hidden-md-down">
      Latest activity
    </h3>

    <div className="project-card__activity hidden-md-down">
      <div className="project-card__activity-pic main-userpic main-userpic-sm">
        <ProjectCardUserPic />
      </div>

      <span className="project-card__activity-text">
        {cutAt(children, 80)}
      </span>
    </div>
  </div>
)

const NdaIcon = () => (
  <i className="project-card__remark icon-eye-crossed hidden-md-down" />
)

const InfoLink = ({ to, text }) => (
  <Link to={to} className="main-button main-button--clear-black main-button--md m-b-10">
    {text}
  </Link>
)

InfoLink.propTypes = {
  to: PropTypes.string,
  text: PropTypes.string.isRequired
}

const InfoButton = ({ onClick, text }) => (
  <button
    className="main-button main-button--clear-black main-button--md m-b-10"
    onClick={onClick}
  >
    {text}
  </button>
)

InfoButton.propTypes = {
  onClick: PropTypes.func,
  text: PropTypes.string.isRequired
}

export {
  Icon,
  Price,
  Title,
  Footer,
  Status,
  NdaIcon,
  Content,
  Sidebar,
  Activity,
  InfoLink,
  InfoButton,
  ProjectTime,
  DetailsItem,
  Description,
  DetailsGroup
}
