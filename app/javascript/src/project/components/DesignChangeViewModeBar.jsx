import React from 'react'
import partial from 'lodash/partial'
import classNames from 'classnames'

const DesignChangeViewModeBar = ({ viewMode, onChange }) => (
  <div className="resize-panel hidden-sm-down">
    <button onClick={partial(onChange, 'fullscreen')} className={classNames('resize-panel__btn icon-button--grey-black icon-button icon-preview', { 'icon-button--active': viewMode === 'fullscreen' })} type="button" />
    <button onClick={partial(onChange, 'normal')} className={classNames('resize-panel__btn icon-button--grey-black icon-button icon-fullsize', { 'icon-button--active': viewMode === 'normal' })} type="button" />
  </div>
)

export default DesignChangeViewModeBar
