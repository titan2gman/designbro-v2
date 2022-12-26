import _ from 'lodash'
import { connect } from 'react-redux'

import {
  changeProjectProductAttributes,
} from '@actions/newProject'

import BrandsModal from '@components/new-project-product-step/BrandsModal'

const mapStateToProps = (state) => {
  return {
    brands: _.values(state.entities.brands),
    attributes: state.newProject.stepProductAttributes
  }
}

export default connect(mapStateToProps, {
  onChange: changeProjectProductAttributes
})(BrandsModal)
