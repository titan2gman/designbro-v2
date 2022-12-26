import React from 'react'

import { connect } from 'react-redux'

import {
  getDesignerNdas,
  getDesignerNdasLoaded
} from '@reducers/designerNdas'

import { loadDesignerNdas } from '@actions/designerNdas'

import DesignerNdasList from '@ndas/components/DesignerNdasList'

class DesignerNdasListContainer extends React.Component {
  componentDidMount () {
    this.props.loadDesignerNdas()
  }

  render () {
    return <DesignerNdasList {...this.props} />
  }
}

const mapStateToProps = (state) => ({
  designerNdas: getDesignerNdas(state),
  loading: !getDesignerNdasLoaded(state)
})

const mapDispatchToProps = {
  loadDesignerNdas
}

export default connect(mapStateToProps, mapDispatchToProps)(
  DesignerNdasListContainer
)
