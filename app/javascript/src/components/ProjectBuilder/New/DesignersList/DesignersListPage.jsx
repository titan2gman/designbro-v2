import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import SubmitPanel from '../../SubmitPanel'
import FormButtonWrapper from '@components/FormButtonWrapper'
import Button from '@components/Button'
import DesignersList from './DesignersListContainer'

const DesignersListPage = ({ canContinue, onBackButtonClick, onContinue }) => (
  <main className="product-step">
    <div className="main-subheader">
      <h1 className="bfs-subheader__title main-subheader__title">
        Choose the designer you'd like to work with
      </h1>
    </div>

    <DesignersList />

    <SubmitPanel
      onBackButtonClick={onBackButtonClick}
    >
      <Button
        disabled={!canContinue}
        onClick={onContinue}
      >
        Continue
      </Button>
    </SubmitPanel>
  </main>
)

export default DesignersListPage
