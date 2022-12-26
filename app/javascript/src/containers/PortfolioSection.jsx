import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import React, { Component } from 'react'

import { loadPortfolioImages } from '@actions/portfolioImages'
import { getPortfolioImages, isPortfolioImagesLoaded } from '@reducers/portfolioImages'

import Spinner from '@components/Spinner'
import PortfolioSection from '@components/PortfolioSection'

class PortfolioSectionContainer extends Component {
  componentWillMount () {
    this.props.loadPortfolioImages()
  }

  render () {
    const { portfolioImages, portfolioImagesLoading } = this.props

    return (
      <Spinner loading={portfolioImagesLoading}>
        {portfolioImages.length > 0 && <PortfolioSection sliderImagesNames={portfolioImages} />}
      </Spinner>
    )
  }
}

PortfolioSectionContainer.propTypes = {
  portfolioType: PropTypes.string.isRequired,
  portfolioImagesLoading: PropTypes.bool.isRequired,
  portfolioImages: PropTypes.arrayOf(PropTypes.string).isRequired,

  loadPortfolioImages: PropTypes.func.isRequired
}

const mapStateToProps = (state) => ({
  portfolioImages: getPortfolioImages(state),
  portfolioImagesLoading: !isPortfolioImagesLoaded(state)
})

const mapDispatchToProps = (dispatch, ownProps) => ({
  loadPortfolioImages: () => dispatch(loadPortfolioImages(ownProps.portfolioType))
})

export default connect(mapStateToProps, mapDispatchToProps)(PortfolioSectionContainer)
