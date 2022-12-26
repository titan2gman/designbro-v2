import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

const Connector = ({ completed }) => (
  <span className={classNames('main-stepper__connector', { completed })} />
)

const StepGroup = ({ children, className }) => (
  <div className={classNames('join-designer__stepper main-stepper', className)}>
    {children}
  </div>
)

StepGroup.propTypes = {
  children: PropTypes.node.isRequired
}

const Step = ({ active, completed, title }) => (
  <>
    <Connector completed={completed || active} />

    <div
      title={title}
      className={classNames(
        'main-stepper__item', {
          active,
          completed
        }
      )}
    >
      <span
        className={classNames(
          'main-stepper__item-icon', {
            active,
            completed
          }
        )}
      />
    </div>
  </>
)

Step.propTypes = {
  title: PropTypes.string.isRequired,
  active: PropTypes.bool,
  completed: PropTypes.bool
}

export { StepGroup, Step }
