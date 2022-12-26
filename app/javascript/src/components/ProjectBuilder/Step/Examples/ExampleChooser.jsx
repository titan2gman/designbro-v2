import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { Spinner } from '@components/withSpinner'

const ExampleChooser = ({ inProgress, image, canMarkExampleAsBad, canMarkExampleAsGood, openStep, markExampleAsBad, markExampleAsGood, markExampleAsSkip }) =>(
  <div className="bfs-content__flex-item bfs-content__flex-item--order1">
    <div className="bfs-logo-block text-center">
      <main>
        {inProgress ? <Spinner /> : (
          <div className="bfs-logo-block__example">
            <div className="bfs-logo-block__example-img">
              <img alt="example" src={image.url} />
            </div>

            <div className="bfs-logo-block__example-btns">
              <button
                type="button"
                className="bfs-logo-block__example-btn"
                onClick={() => canMarkExampleAsBad ? markExampleAsBad(image.id, openStep) : markExampleAsSkip(image.id, openStep)}
              >
                <i className="icon-cross" />
              </button>

              <button type="button"
                onClick={() => markExampleAsSkip(image.id, openStep)}
                className="bfs-logo-block__example-btn-skip font-13 text-center font-bold cursor-pointer"
              >
                Skip image
              </button>

              <button
                type="button"
                onClick={canMarkExampleAsGood ? () => markExampleAsGood(image.id, openStep) : null}
                className={classNames('bfs-logo-block__example-btn', { disabled: !canMarkExampleAsGood })}
              >
                <i className="icon-check" />
              </button>
            </div>
          </div>
        )}
      </main>
    </div>
  </div>
)

const imageShape = PropTypes.shape({
  id: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired
})

ExampleChooser.propTypes = {
  markExampleAsBad: PropTypes.func.isRequired,
  markExampleAsGood: PropTypes.func.isRequired,
  markExampleAsSkip: PropTypes.func.isRequired,
  canMarkExampleAsBad: PropTypes.bool.isRequired,
  canMarkExampleAsGood: PropTypes.bool.isRequired,
  image: imageShape.isRequired
}

export default ExampleChooser
